package steam;

/**
	The callbacks of the peer-to-peer networking, given to `Networking.startP2P`.
**/
typedef NetworkApi = {
	/**
		Called when a user wants to connect: returns `true` to accept the connection.
	**/
	function onConnectionRequest( u : User ) : Bool;
	/**
		Called when the connection to a user failed.
	**/
	function onConnectionError( u : User, error : NetworkStatus ) : Void;
	/**
		Called when a packet was received from a user. With `Networking.USE_MULTITHREAD`, the bytes are only valid during the call.
	**/
	function onData( u : User, data : haxe.io.Bytes ) : Void;
}

/**
	The error of a peer-to-peer connection (Steamworks `EP2PSessionError`).
**/
enum abstract NetworkStatus(Int) {
	/**
		No error.
	**/
	var None = 0;
	/**
		The remote user is not running the same game.
	**/
	var NotRunningApp = 1;
	/**
		The local user doesn't own the game.
	**/
	var NoRigtsToApp = 2;
	/**
		The remote user is not logged in to Steam.
	**/
	var DestinationNotLoggedIn = 3;
	/**
		The connection timed out.
	**/
	var Timeout = 4;
}

/**
	How a packet is sent (Steamworks `EP2PSend`).
**/
enum abstract PacketType(Int) {
	/**
		Unreliable, can be dropped or arrive out of order (up to 1200 bytes).
	**/
	var Unreliable = 0;
	/**
		Unreliable, and dropped if the connection is not established yet.
	**/
	var UnreliableNoDelay = 1;
	/**
		Reliable and in order (up to 1MB).
	**/
	var Reliable = 2;
	/**
		Reliable, with small packets grouped together (Nagle algorithm).
	**/
	var ReliableWithBuffering = 3;
}

/**
	The state of a peer-to-peer session with a user (Steamworks `P2PSessionState_t`).
**/
typedef NetworkSessionData = {
	/**
		Tells if the connection is being established.
	**/
	var connecting : Bool;
	/**
		Tells if the connection is established.
	**/
	var alive : Bool;
	/**
		Tells if the connection goes through a Steam relay server.
	**/
	var relay : Bool;
	/**
		The last error.
	**/
	var error : NetworkStatus;
	/**
		The number of bytes waiting to be sent.
	**/
	var bytesSendQueue : Int;
	/**
		The number of packets waiting to be sent.
	**/
	var packetSendQueue : Int;
	/**
		The IP of the remote user (if not relayed).
	**/
	var remoteIP : Int;
	/**
		The port of the remote user (if not relayed).
	**/
	var remotePort : Int;
}

private typedef ThreadData = {
	var consumed : Int;
	var disposed : Int;
	var users : Array<UID>;
	var length : Array<Int>;
	var lock : sys.thread.Mutex;
}

/**
	The peer-to-peer networking between users (Steamworks `ISteamNetworking`): packets are sent to a user with `sendP2P`, and received by the `NetworkApi` given to `startP2P`.
**/
@:hlNative("steam")
class Networking {

	static var initDone = false;
	static var api : NetworkApi;
	static var connections : Map<String,UID> = new Map();
	static var buffer : hl.Bytes = null;
	static var bufferSize = 0;

	/**
		Reads the packets in a separate thread (they are still given to `onData` in the main thread). Must be set before `startP2P`.
	**/
	public static var USE_MULTITHREAD(default,set) : Bool;

	static function set_USE_MULTITHREAD(b) {
		if( USE_MULTITHREAD == b ) return b;
		if( initDone ) throw "You cannot change Mulithread after init";
		USE_MULTITHREAD = b;
		return b;
	}

	/**
		Starts receiving connections and packets with the callbacks of `napi`.
	**/
	public static function startP2P( napi : NetworkApi ) {
		api = napi;

		if( initDone ) return;

		initDone = true;
		// P2PSessionRequest_t
		Api.registerGlobalEvent(1202, function(data:{uid:UID}) {
			if( api == null ) return;
			var user = User.fromUID(data.uid);
			if( api.onConnectionRequest(user) ) {
				if( !accept_p2p_session(data.uid) )
					throw "fail to accept p2p session";
				addConnection(user);
			}
		});

		// P2PSessionConnectFail_t
		Api.registerGlobalEvent(1203, function(data:{uid:UID, error:NetworkStatus}) {
			if( api != null )
				api.onConnectionError(User.fromUID(data.uid), data.error);
		});

		if( USE_MULTITHREAD ) {
			var t : ThreadData = { consumed : 0, disposed : 0, users : [], length : [], lock : new sys.thread.Mutex() };
			haxe.MainLoop.add(checkP2PMain.bind(t));
			sys.thread.Thread.create(threadLoop.bind(t));
		} else
			haxe.MainLoop.add(checkP2PMessage);
	}

	static function checkP2PMessage() {
		if( api == null ) return;
		// decode message !
		var len = 0;
		while( true ) {
			var result;
			try {
				result = is_p2p_packet_available(len, 0);
			} catch( e : Dynamic ) {
				var flags = new haxe.EnumFlags<hl.UI.DialogFlags>();
				flags.set(IsError);
				hl.UI.dialog("Error", "An error occured in network layer, Steam can no longer be reached.\n("+Std.string(e)+")", flags);
				Sys.exit(1);
				return;
			}
			if( !result )
				break;
			if( len > bufferSize ) {
				bufferSize = len;
				buffer = new hl.Bytes(bufferSize);
			}
			var uid = read_p2p_packet(buffer, bufferSize, len, 0);
			if( uid == null ) continue;
			api.onData(User.fromUID(uid), buffer.toBytes(len));
		}
	}

	static function threadLoop( t : ThreadData ) {
		try {
			var len = 0;
			var pos = 0;
			while( true ) {
				if( api != null ) {
					while( true ) {
						var result = is_p2p_packet_available(len, 0);
						if( !result )
							break;
						if( len + pos > bufferSize ) {
							bufferSize = len + pos;
							var newBuf = new hl.Bytes(bufferSize);
							newBuf.blit(0, buffer, 0, pos);
							buffer = newBuf;
						}
						var uid = read_p2p_packet(buffer.offset(pos), bufferSize - pos, len, 0);
						if( uid == null ) continue;
						pos += len;
						t.lock.acquire();
						if( t.disposed > 0 ) {
							buffer.blit(0, buffer, t.disposed, pos - t.disposed);
							pos -= t.disposed;
							t.consumed -= t.disposed;
							t.disposed = 0;
						}
						t.length.push(len);
						t.users.push(uid);
						t.lock.release();
					}
				}
				Sys.sleep(1/30);
			}
		} catch( e : Dynamic ) {
			var flags = new haxe.EnumFlags<hl.UI.DialogFlags>();
			flags.set(IsError);
			hl.UI.dialog("Error", "An error occured in network layer, Steam can no longer be reached.\n("+Std.string(e)+")", flags);
			Sys.exit(1);
		}
	}

	static function checkP2PMain( t : ThreadData ) {
		if( api == null ) return;
		static var tmpBytes = haxe.io.Bytes.alloc(1);
		while( t.users.length > 0 ) {
			t.lock.acquire();
			var u = t.users.shift();
			var len = t.length.shift();
			var buffer = buffer; // keep for GC - if expanded on server
			@:privateAccess tmpBytes.b = buffer.offset(t.consumed);
			@:privateAccess tmpBytes.length = len;
			t.disposed = 0; // prevent any offset/discard
			t.consumed += len; // store in case of exception in onData
			t.lock.release();
			api.onData(User.fromUID(u), tmpBytes);
		}
		if( t.consumed > 0 && t.disposed != t.consumed ) {
			t.lock.acquire();
			t.disposed = t.consumed;
			t.lock.release();
		}
	}

	/**
		Sends `len` bytes of `data` from `pos` (all by default) to the user, opening the connection if needed. Returns `false` on failure.
	**/
	public static function sendP2P( user : User, data : haxe.io.Bytes, type : PacketType, pos = 0, len = -1 ) {
		if( len < 0 ) len = data.length;
		if( !send_p2p_packet(user.uid, (data:hl.Bytes).offset(pos), len, type, 0) )
			return false;
		addConnection(user);
		return true;
	}

	/**
		Closes the connection with the user (after a short delay, so that the pending packets are sent).
	**/
	public static function closeSession( user : User ) {
		@:privateAccess {
			if( !user.p2pcnx ) return;
			user.p2pcnx = false;
		}
		// we need to delay the session close so some pending packets are delivered
		haxe.Timer.delay(() -> if( @:privateAccess !user.p2pcnx ) close_p2p_session(user.uid),100);
		connections.remove(user.uid.toString());
	}

	static inline function addConnection( user : User ) {
		@:privateAccess if( !user.p2pcnx ) {
			user.p2pcnx = true;
			connections.set(user.uid.toString(), user.uid);
		}
	}

	/**
		Stops receiving packets and closes all the connections.
	**/
	public static function closeP2P() {
		api = null;
		var cnx = connections;
		connections = new Map();
		for( c in cnx )
			closeSession(User.fromUID(c));
	}


	/**
		Returns the state of the connection with the user.
	**/
	public static function getSessionData( user : User ) : NetworkSessionData {
		return get_p2p_session_data(user.uid);
	}

	// -- native

	static function send_p2p_packet( to : UID, data : hl.Bytes, dataLen : Int, type : PacketType, channel : Int ) : Bool {
		return false;
	}

	static function read_p2p_packet( out : hl.Bytes, maxLen : Int, len : hl.Ref<Int>, channel : Int ) : UID {
		return null;
	}

	static function is_p2p_packet_available( len : hl.Ref<Int>, channel : Int ) {
		return false;
	}

	static function get_p2p_session_data( uid : UID ) : Dynamic {
		return null;
	}

	static function accept_p2p_session( uid : UID ) : Bool {
		return false;
	}

	static function close_p2p_session( uid : UID ) : Bool {
		return false;
	}

}
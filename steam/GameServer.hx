package steam;

/**
	The authentication mode of a game server (Steamworks `EServerMode`).
**/
enum abstract ServerMode(Int) {
	/**
		No authentication of the users.
	**/
	var NoAuthentification = 1;
	/**
		The users are authenticated by Steam.
	**/
	var Authentification = 2;
	/**
		The users are authenticated, and the server is VAC secured.
	**/
	var AuthentificationAndSecure = 3;
}

/**
	A dedicated game server registered on Steam (Steamworks `SteamGameServer`), and the list of the servers.
**/
@:hlNative("steam")
class GameServer {

	static var initDone = false;
	static var globalEvents = new Map<Int,Dynamic->Void>();

	/**
		Sets the function called for a game server callback, by its callback id.
	**/
	@:noComplete public static function registerGlobalEvent( event : Int, callb : Dynamic -> Void ) {
		globalEvents.set(event, callb);
	}

	/**
		Initializes the game server on the local IP, with the game and query ports, the authentication mode and the version of the game (`port` is not used). Its callbacks are then run by the main loop. Returns `false` on failure.
	**/
	public static function init( ip : sys.net.Host, port : Int, gameport : Int, queryPort : Int, serverMode : ServerMode, version : String ) {
		var ip = ip.ip;
		var convIP = (ip >>> 24) | ((ip >> 8) & 0xFF00) | ((ip << 8) & 0xFF0000) | (ip << 24);
		if( !gameserver_init(convIP, port, gameport, queryPort, serverMode, @:privateAccess version.toUtf8()) )
			return false;
		if( initDone ) return true;
		haxe.MainLoop.add(runGameServer);
		gameserver_setup(onGlobalEvent);
		return true;
	}

	/**
		Sets the mod folder, the product name and the game description, and marks the server as dedicated.
	**/
	public static function setConfig( modDir : String, product : String, desc : String ) {
		@:privateAccess gameserver_config( modDir.toUtf8(), product.toUtf8(), desc.toUtf8() );
	}

	/**
		Sets the information shown in the server browser: maximum players, password protection, name, number of bots and map name.
	**/
	public static function setInfo( maxPlayers, password, serverName : String, botCount : Int, mapName : String ) {
		@:privateAccess gameserver_info( maxPlayers, password, serverName.toUtf8(), botCount, mapName.toUtf8() );
	}

	static function onGlobalEvent( event : Int, data : Dynamic ) {
		var callb = globalEvents.get(event);
		if( callb == null )
			callb = @:privateAccess Api.globalEvents.get(event);
		if( callb != null )
			callb(data);
		else
			customTrace("Unhandled server event #"+event+" ("+data+")");
	}

	/**
		Prints a log message of the game server. Prints it with `Sys.println` by default.
	**/
	public static dynamic function customTrace(str:String) {
		Sys.println(str);
	}

	/**
		Enables the heartbeats sent to the master server, so that the server is listed.
	**/
	@:hlNative("steam", "gameserver_enable_heartbeats")
	public static function enableHeartbeats( b : Bool ) {
	}

	/**
		Returns the public IP of the server.
	**/
	@:hlNative("steam", "gameserver_get_public_ip")
	public static function getPublicIP() : Int {
		return 0;
	}

	/**
		Returns the Steam id of the server.
	**/
	@:hlNative("steam", "gameserver_get_steam_id")
	public static function getSteamID() : UID {
		return null;
	}

	/**
		Logs the server on Steam anonymously, retrying `retries` times: `onLogin` is called with `true` when connected, or `false` on failure. The server logs on again when disconnected.
	**/
	public static function logonAnonymous( onLogin : Bool -> Void, retries = 3 ) {

		var ucb = 100;
		//SteamServersConnected_t
		registerGlobalEvent(ucb + 1, function(_:Dynamic) {
			if( onLogin == null ) return;
			registerGlobalEvent(ucb + 3, onDisconnected);
			onLogin(true);
			onLogin = null;
		});
		function failure(r:Dynamic) {
			customTrace("CONNECT FAILURE " + r);
			if(retries > 0) {
				logonAnonymous(onLogin, retries-1);
			}
			else {
				if( onLogin == null )
					return;
				onLogin(false);
			}
			onLogin = null;
		}
		//SteamServerConnectFailure_t
		registerGlobalEvent(ucb + 2, failure);
		//SteamServersDisconnected_t
		registerGlobalEvent(ucb + 3, failure);
		registerGlobalEvent(ucb + 15, function(_:Dynamic) { /* ignore VAC flag */ });

		gameserver_logon_anonymous();
	}

	static function onDisconnected(_:Dynamic) {
		customTrace("Gameserver disconnected, retrying...");
		logonAnonymous(function(b) {
			if( b ) {
				// seems like it's never called (no SteamServersConnected_t after retry?)
				customTrace("Gameserver reconnected as "+getSteamID().getBytes().toHex());
				return;
			}
			haxe.Timer.delay(onDisconnected.bind(null), 10000);
		});
	}

	/**
		Shuts down the game server.
	**/
	@:hlNative("steam", "gameserver_shutdown")
	public static function shutdown() {
	}

	static function runGameServer() {
		gameserver_runcallbacks();
	}

	static function gameserver_init( ip : Int, port : Int, gameport : Int, queryport : Int, serverMode : ServerMode, version : hl.Bytes ) : Bool {
		return false;
	}

	static function gameserver_runcallbacks() {
	}

	static function gameserver_logon_anonymous() {
	}

	static function gameserver_setup( onGlobalEvent : Int -> Dynamic -> Void ) {
	}

	static function gameserver_config( modDir : hl.Bytes, name : hl.Bytes, desc : hl.Bytes ) {
	}

	static function gameserver_info( maxPlayers : Int, password : Bool, serverName : hl.Bytes, botCount : Int, mapName : hl.Bytes ) {
	}

	/**
		Requests the list of the internet servers of the app, with Steam server filters (field names and values): `onResults` is called with all the servers.
	**/
	public static function requestInternetServerList( appId : Int, ?filters : {}, ?onResults : Array<{ id : UID, ip : Int, port : Int, ping : Int }> -> Void ) {
		var fields = filters == null ? [] : Reflect.fields(filters);
		var n = new hl.NativeArray(fields.length * 2);
		var p = 0;
		for( f in fields ) {
			n[p++] = @:privateAccess f.toUtf8();
			n[p++] = @:privateAccess Std.string(Reflect.field(filters,f)).toUtf8();
		}
		var results = [];
		request_internet_server_list(appId, n, function(r) if( r != null ) results.push(r) else onResults(results));
	}

	static function request_internet_server_list( appId : Int, filters : hl.NativeArray<hl.Bytes>, onResult : Dynamic -> Void ) {
	}

}
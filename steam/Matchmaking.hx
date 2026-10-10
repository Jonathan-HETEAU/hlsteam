package steam;

/**
	The visibility of a lobby (Steamworks `ELobbyType`).
**/
enum abstract LobbyKind(Int) {
	/**
		Only way to join the lobby is to invite to someone else
	**/
	public var Private = 0;
	/**
		Shows for friends or invitees, but not in lobby list
	**/
	public var FriendsOnly = 1;
	/**
		Visible for friends and in lobby list
	**/
	public var Public = 2;
	/**
		Returned by search, but not visible to other friends
	**/
	public var Invisible = 3;
}

/**
	A comparison of a lobby list filter (Steamworks `ELobbyComparison`): how the lobby value compares to the filter value.
**/
enum abstract ComparisonFilter(Int) {
	/**
		Less than or equal.
	**/
	var LessThanEqual = -2;
	/**
		Less than.
	**/
	var LessThan = -1;
	/**
		Equal.
	**/
	var Equal = 0;
	/**
		Greater than.
	**/
	var GreaterThan = 1;
	/**
		Greater than or equal.
	**/
	var GreaterThanEqual = 2;
	/**
		Not equal.
	**/
	var NotEqual = 3;
}

/**
	The geographic distance of the lobbies to list (Steamworks `ELobbyDistanceFilter`).
**/
enum abstract DistanceFilter(Int) {
	/**
		The same region only.
	**/
	var Close = 0;
	/**
		The same or nearby regions.
	**/
	var Default = 1;
	/**
		About half-way around the globe.
	**/
	var Far = 2;
	/**
		No filtering.
	**/
	var Worldwide = 3;
}

private enum LobbyChatFlag {
	Entered;
	Left;
	Disconnected;
	Kicked;
	Banned;
}

/**
	The filters of `Matchmaking.requestLobbyList`.
**/
typedef LobbyListFilters = {
	/**
		Filters on string lobby data.
	**/
	@:optional var stringFilters : Array<{ key : String, value : String, comparison : ComparisonFilter }>;
	/**
		Filters on numerical lobby data.
	**/
	@:optional var intFilters : Array<{ key : String, value : Int, comparison : ComparisonFilter }>;
	/**
		Sorts the lobbies by the distance of the numerical data to the value.
	**/
	@:optional var nearFilters : Array<{ key : String, value : Int }>;
	/**
		The geographic distance.
	**/
	@:optional var distance : DistanceFilter;
	/**
		The minimum number of free slots.
	**/
	@:optional var availableSlots : Int;
}

/**
	The lobbies: creation, search and invitations (Steamworks `ISteamMatchmaking`).
**/
@:hlNative("steam")
class Matchmaking {

	static var lobbies = new Map<String,Lobby>();
	static var _init = init();

	static function init() {
		var eid = 500;
		var fid = 300;

		// LobbyDataUpdate_t
		Api.registerGlobalEvent(eid + 5, function(data:{lobby:UID, user:Null<UID>}) {
			if( data == null ) {
				Api.customTrace("Failed to retreive data");
				return;
			}
			var l = getLobby(data.lobby);
			if( l == null ) return;
			if( data.user != null )
				l.onUserDataUpdated(User.fromUID(data.user));
			else
				l.onDataUpdated();
		});

		// LobbyChatUpdate_t
		Api.registerGlobalEvent(eid + 6, function(data:{lobby:UID, user:UID, origin:UID, flags:haxe.EnumFlags<LobbyChatFlag>}) {
			var l = getLobby(data.lobby);
			if( l == null ) return;
			if( data.flags.has(Entered) )
				l.onUserJoined(User.fromUID(data.user));
			else
				l.onUserLeft(User.fromUID(data.user)); // no need for reason for now
		});

		// LobbyChatMsg_t
		Api.registerGlobalEvent(eid + 7, function(data:{lobby:UID, user:UID, type:Lobby.ChatMessageType, cid:Int}) {
			var l = getLobby(data.lobby);
			if( l == null ) return;
			l.onChatMessage(data.type, data.cid);
		});

		// GameLobbyJoinRequested_t
		Api.registerGlobalEvent(fid + 33, function(data:{user:UID, lobby:UID}) {
			var l = lobbies.get(data.lobby.toString());
			if( l == null )
				l = new Lobby(data.lobby);
			onInvited(l, User.fromUID(data.user));
		});

		return true;
	}

	static function getLobby( lid : UID ) {
		var l = lobbies.get(lid.toString());
		if( l == null )
			Api.customTrace("Lobby not found " + lid);
		return l;
	}

	/**
		Searches lobbies: `onLobbyList` is called with the lobbies found, or `null` on error.
	**/
	public static function requestLobbyList( onLobbyList : Array<Lobby> -> Void, ?filters : LobbyListFilters, ?resultsCount : Int ) {
		if( filters != null ) {
			var f = filters;
			if( f.stringFilters != null )
				for( f in f.stringFilters )
					@:privateAccess request_filter_string(f.key.toUtf8(), f.value.toUtf8(), f.comparison);
			if( f.intFilters != null )
				for( f in f.intFilters )
					@:privateAccess request_filter_numerical(f.key.toUtf8(), f.value, f.comparison);
			if( f.nearFilters != null )
				for( f in f.nearFilters )
					@:privateAccess request_filter_near_value(f.key.toUtf8(), f.value);
			if( f.distance != null )
				request_filter_distance(f.distance);
			if( f.availableSlots != null )
				request_filter_slots_available(f.availableSlots);
		}
		if( resultsCount != null )
			request_result_count(resultsCount);
		request_lobby_list(function(count, error) {
			if( error ) {
				onLobbyList(null);
				return;
			}
			onLobbyList([for( i in 0...count ) new Lobby(get_lobby_by_index(i))]);
		});
	}

	static function request_lobby_list( onResult : Callback<Int> ) : AsyncCall {
		return null;
	}

	/**
		Creates a lobby, and joins it: `onResult` is called with the lobby, or `null` on error.
	**/
	public static function createLobby( kind : LobbyKind, maxPlayers : Int, onResult : Lobby -> Void ) : AsyncCall {
		return create_lobby(kind, maxPlayers, function(uid, error) {
			if( error ) {
				onResult(null);
				return;
			}
			var l = new Lobby(uid);
			@:privateAccess l.register();
			onResult(l);
		});
	}

	static dynamic function onInvited( lobby : Lobby, by : User ) {
		Api.customTrace("Invitation ignored - no checkInvite registered");
	}

	static var inviteCheck = false;
	/**
		Sets the function called when the user accepts an invitation to a lobby, and calls it if the game was launched by an invitation (`+connect_lobby` command line argument).
	**/
	public static function checkInvite( onInvite : Lobby -> Void ) {

		onInvited = function(lobby, _) onInvite(lobby);

		if( inviteCheck ) return;

		inviteCheck = true;
		var args = Sys.args();
		if( args[0] == "+connect_lobby" ) {
			var uid = haxe.Int64.parseString(args[1]);
			var bytes = new hl.Bytes(8);
			bytes.setI32(0, uid.low);
			bytes.setI32(4, uid.high);
			var uid : UID = cast bytes;
			onInvite(new Lobby(uid));
		}
	}

	static function create_lobby( kind : LobbyKind, maxPlayers : Int, onResult : Callback<UID> ) : AsyncCall {
		return null;
	}

	static function get_lobby_by_index( index : Int ) : UID {
		return null;
	}

	static function request_filter_string( key : hl.Bytes, value : hl.Bytes, comp : ComparisonFilter ) {
	}

	static function request_filter_numerical( key : hl.Bytes, value : Int, comp : ComparisonFilter ) {
	}

	static function request_filter_near_value( key : hl.Bytes, value : Int ) {
	}

	static function request_filter_slots_available( value : Int ) {
	}

	static function request_filter_distance( value : DistanceFilter ) {
	}

	static function request_result_count( value : Int ) {
	}

}


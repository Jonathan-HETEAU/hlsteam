package steam;

/**
	The information of a user that changed (Steamworks `EPersonaChange`), given to the `User.requestInformation` callback.
**/
enum Changed {
	/**
		The name.
	**/
	Name;
	/**
		The online status.
	**/
	Status;
	/**
		The user came online.
	**/
	ComeOnline;
	/**
		The user went offline.
	**/
	GoneOffline;
	/**
		The game played.
	**/
	GamePlayed;
	/**
		The game server.
	**/
	GameServer;
	/**
		The avatar.
	**/
	Avatar;
	/**
		The user joined a group chat or lobby.
	**/
	JoinedSource;
	/**
		The user left a group chat or lobby.
	**/
	LeftSource;
	/**
		The relationship with the user.
	**/
	RelationshipChanged;
	/**
		The name was received for the first time.
	**/
	NameFirstSet;
	/**
		The Facebook information.
	**/
	FacebookInfo;
	/**
		The nickname given by the current user.
	**/
	Nickname;
	/**
		The Steam level.
	**/
	SteamLevel;
}

/**
	The size of an avatar image.
**/
enum AvatarSize {
	/**
		32x32 pixels.
	**/
	Small;
	/**
		64x64 pixels.
	**/
	Medium;
	/**
		184x184 pixels or more.
	**/
	Large;
}

/**
	A Steam user. Users are unique for a UID: get them with `fromUID`.
**/
@:hlNative("steam")
class User {

	/**
		The Steam id of the user.
	**/
	public var uid(default, null) : UID;
	/**
		The name of the user (cached once read). Can be unknown until `requestInformation` completes.
	**/
	public var name(get, never) : String;
	var cachedName : String;
	var waiting : Array<haxe.EnumFlags<Changed>->Void>;
	var p2pcnx : Bool;

	function new(uid) {
		this.uid = uid;
		waiting = [];
	}

	/**
		Returns the lower 32 bits of the Steam id (the account id), see `fromUID32`.
	**/
	public function getID32() {
		// lower 32 bits seems to be unique, then padded with 0x01100001
		return (cast uid : hl.Bytes).getI32(0);
	}

	function get_name() {
		if( cachedName != null ) return cachedName;
		cachedName = @:privateAccess String.fromUTF8(get_user_name(uid));
		return cachedName;
	}

	/**
		Requests the name and avatar (or only the name) of the user: `onChange` is called with the changed information when received.
	**/
	public function requestInformation( onChange, nameOnly = false ) {
		waiting.push(onChange);
		request_user_information(uid, nameOnly);
	}

	/**
		Returns the name and the UID of the user.
	**/
	public function toString() {
		return name+"(" + uid.toString() + ")";
	}

	#if heaps
	/**
		Returns the avatar of the user as a Heaps tile (a black tile if unknown). Only with Heaps.
	**/
	public function getAvatarImage(size) : h2d.Tile {
		var data = getAvatar(size);
		if( data == null )
			return h2d.Tile.fromColor(0, 32, 32);
		return h2d.Tile.fromPixels(new hxd.Pixels(data.width, data.height, data.rgba, RGBA));
	}
	#end

	/**
		Returns the avatar of the user as RGBA pixels, or `null` if not loaded yet (see `requestInformation`).
	**/
	public function getAvatar( size : AvatarSize ) : { width : Int, height : Int, rgba : haxe.io.Bytes } {
		var w = 0;
		var h = 0;
		var bytes = get_user_avatar(uid, size.getIndex(), w, h);
		if( bytes == null ) return null;
		return { width : w, height : h, rgba : bytes.toBytes(w * h * 4) };
	}

	function onDataUpdated(flags) {
		if( waiting.length > 0 ) {
			var old = waiting;
			waiting = [];
			for( w in old ) w(flags);
		}
	}

	static function get_user_name( uid : UID ) : hl.Bytes {
		return null;
	}

	// this will most likely leak but we don't care
	static var users = new Map<String, User>();

	/**
		Returns the user of the Steam id.
	**/
	public static function fromUID( uid : UID ) {
		var u = users.get(uid.toString());
		if( u != null ) return u;
		u = new User(uid);
		users.set(uid.toString(), u);
		return u;
	}

	/**
		Returns the user of the account id returned by `getID32` (an individual account of the public universe).
	**/
	public static function fromUID32( uid : Int ) {
		var bytes = new hl.Bytes(8);
		bytes.setI32(0, uid);
		bytes.setI32(4, 0x01100001);
		return fromUID(cast bytes);
	}

	static function request_user_information( uid : UID, nameOnly : Bool ) {
		return false;
	}

	static function get_user_avatar( uid : UID, size : Int, width : hl.Ref<Int>, height : hl.Ref<Int> ) : hl.Bytes {
		return null;
	}

}
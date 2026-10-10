package steam;

/**
	The relationships to list with `Friends.getFriends` (Steamworks `EFriendFlags`), combined with `|`.
**/
enum abstract FriendFlags(Int) {
	/**
		None.
	**/
	var None = 0;
	/**
		Users blocked by the user.
	**/
	var Blocked = 1;
	/**
		Users who sent a friend request.
	**/
	var FriendshipRequested = 2;
	/**
		Regular friends.
	**/
	var Immediate = 4;
	/**
		Users in the same Steam groups.
	**/
	var ClanMember = 8;
	/**
		Users on the same game server.
	**/
	var OnGameServer = 0x10;
	/**
		Users to whom the user sent a friend request.
	**/
	var RequestingFrienship = 0x80;
	/**
		Users whose information was requested.
	**/
	var RequestingInfo = 0x100;
	/**
		Ignored users.
	**/
	var Ignored = 0x200;
	/**
		Ignored friends.
	**/
	var IgnoredFriend = 0x400;
	/**
		Users in the same chats.
	**/
	var ChatMember = 0x1000;
	/**
		All the relationships.
	**/
	var All = 0xFFFF;
	@:op(a | b) static function or(a:FriendFlags, b:FriendFlags):FriendFlags;
}

/**
	A dialog of the Steam overlay, opened with `Friends.activateOverlay`.
**/
enum abstract OverlayKind(String) {

	/**
		The overlay without dialog.
	**/
	var None = "none";

	/**
		The friends list.
	**/
	var Friends = "Friends";
	/**
		The Steam Community.
	**/
	var Community = "Community";
	/**
		The recent players.
	**/
	var Players = "Players";
	/**
		The Steam settings.
	**/
	var Settings = "Settings";
	/**
		The Steam group of the game.
	**/
	var OfficialGameGroup = "OfficialGameGroup";
	/**
		The stats of the game.
	**/
	var Stats = "Stats";
	/**
		The achievements of the game.
	**/
	var Achievements = "Achievements";

	// with uid

	/**
		opens the overlay web browser to the specified user or groups profile
	**/
	var SteamID = "steamid";
	/**
		opens a chat window to the specified user, or joins the group chat
	**/
	var Chat = "chat";
	/**
		opens a window to a Steam Trading session that was started with the ISteamEconomy/StartTrade Web API
	**/
	var JoinTrade = "jointrade";
	/**
		opens the overlay web browser to the specified user's stats
	**/
	var UserStats = "stats";
	/**
		opens the overlay web browser to the specified user's achievements
	**/
	var UserAchievements = "achievements";
	/**
		opens the overlay in minimal mode prompting the user to add the target user as a friend
	**/
	var FriendAdd = "friendadd";
	/**
		opens the overlay in minimal mode prompting the user to remove the target friend
	**/
	var FriendRemove = "friendremove";
	/**
		opens the overlay in minimal mode prompting the user to accept an incoming friend invite
	**/
	var FriendRequestAccept = "friendrequestaccept";
	/**
		opens the overlay in minimal mode prompting the user to ignore an incoming friend invite
	**/
	var FriendRequestIgnore = "friendrequestignore";

	/**
		Returns the Steamworks dialog name.
	**/
	public function toString() return this;
}

/**
	What to do when opening the store page in the overlay (Steamworks `EOverlayToStoreFlag`).
**/
enum abstract OverlayToStoreFlag(Int) {
	/**
		Only show the store page.
	**/
	var None = 0;
	/**
		Add the app to the cart.
	**/
	var AddToCart = 1;
	/**
		Add the app to the cart and show the cart.
	**/
	var AddToCartAndShow = 2;
}

/**
	The friends of the user, the overlay dialogs and the rich presence (Steamworks `ISteamFriends`).
**/
@:hlNative("steam")
class Friends {

	/**
		Returns the users with the given relationships (`Immediate` friends by default).
	**/
	public static function getFriends( ?flags : FriendFlags ) {
		if( flags == null ) flags = Immediate;
		return [for( uid in get_friends(flags) ) User.fromUID(uid)];
	}

	/**
		Tells if the user has one of the relationships (`Immediate` friend by default).
	**/
	public static function hasFriend( user : User, ?flags : FriendFlags ) {
		if( flags == null ) flags = Immediate;
		return has_friend(user.uid, flags);
	}

	/**
		Opens a dialog of the Steam overlay, for the user or group `uid` with the dialogs that need one (`SteamID`, `Chat`...).
	**/
	public static function activateOverlay( overlay : OverlayKind, ?uid : UID ) {
		activate_overlay_user( overlay == None ? null : @:privateAccess overlay.toString().toUtf8(), uid);
	}

	/**
		Opens the store page of the app in the Steam overlay.
	**/
	public static function activateOverlayStore( appId : Int, flags : OverlayToStoreFlag ) : Void {}

	/**
		Key `steam_display` requires localized token as value, see https://partner.steamgames.com/doc/api/ISteamFriends#richpresencelocalization
		Set `value` to empty or null to remove the key.
	**/
	public static function setRichPresence( key : String, value : Null<String> ) : Bool {
		return @:privateAccess set_rich_presence(key.toUtf8(), value == null ? null : value.toUtf8());
	}

	/**
		Removes all the rich presence keys of the user.
	**/
	public static function clearRichPresence() : Void {}

	static function get_friends( flags : FriendFlags ) : hl.NativeArray<UID> { return null; }
	static function has_friend( uid : UID, flags : FriendFlags ) : Bool { return false; }
	static function activate_overlay_user( overlay : hl.Bytes, uid : UID ) : Void {}
	static function set_rich_presence( pchKey : hl.Bytes, pchValue : hl.Bytes ) : Bool { return false; }

}

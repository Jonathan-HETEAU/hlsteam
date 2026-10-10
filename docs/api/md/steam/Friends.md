# steam.Friends

**class** · package [`steam`](README.md) · source [`steam/Friends.hx`](../../../../steam/Friends.hx)

The friends of the user, the overlay dialogs and the rich presence (Steamworks `ISteamFriends`).

## Static methods

### getFriends

```haxe
static function getFriends(?flags:FriendFlags):Array<Null<User>>
```

Returns the users with the given relationships (`Immediate` friends by default).

### hasFriend

```haxe
static function hasFriend(user:User, ?flags:FriendFlags):Bool
```

Tells if the user has one of the relationships (`Immediate` friend by default).

### activateOverlay

```haxe
static function activateOverlay(overlay:OverlayKind, ?uid:UID):Void
```

Opens a dialog of the Steam overlay, for the user or group `uid` with the dialogs that need one (`SteamID`, `Chat`...).

### activateOverlayStore

```haxe
static function activateOverlayStore(appId:Int, flags:OverlayToStoreFlag):Void
```

Opens the store page of the app in the Steam overlay.

### setRichPresence

```haxe
static function setRichPresence(key:String, value:Null<String>):Bool
```

Key `steam_display` requires localized token as value, see https://partner.steamgames.com/doc/api/ISteamFriends#richpresencelocalization
Set `value` to empty or null to remove the key.

### clearRichPresence

```haxe
static function clearRichPresence():Void
```

Removes all the rich presence keys of the user.

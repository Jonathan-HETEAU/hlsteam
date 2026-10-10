# steam.Api

**class** · package [`steam`](README.md) · source [`steam/Api.hx`](../../../../steam/Api.hx)

The entry point of the Steam API: call `init` at startup, then use the functions of this class (achievements, stats, leaderboards, overlay, ownership) and of the other classes of the `steam` package. The Steam callbacks are run by `sync`, called automatically by the main loop.

## Static variables

### active

```haxe
static var active(default, null):Bool
```

* Whether the Steam API is detected & initialized or not. If false, all calls will fail

### appId

```haxe
static var appId(default, null):Int
```

The Steam app id given to `init`.

### controllers

```haxe
static var controllers(default, null):Controller
```

* The Steam Controller API

### whenGamepadTextInputDismissed

```haxe
static var whenGamepadTextInputDismissed:() -> Void
```

Called when the gamepad text input is closed, with the entered text, or `null` if it was cancelled.

### whenAchievementStored

```haxe
static var whenAchievementStored:() -> Void
```

Called when an achievement was stored, with its API name.

### whenLeaderboardScoreDownloaded

```haxe
static var whenLeaderboardScoreDownloaded:() -> Void
```

Called with each score downloaded by `downloadLeaderboardScore`.

### whenLeaderboardScoreUploaded

```haxe
static var whenLeaderboardScoreUploaded:() -> Void
```

Called when a score was uploaded by `uploadLeaderboardScore`.

### onOverlay

```haxe
static var onOverlay:() -> Void
```

Called when the Steam overlay is opened (`true`) or closed (`false`).

## Static methods

### init

```haxe
static function init(appId_:Int):Bool
```

* @param appId_	Your Steam APP ID (the numbers on the end of your store page URL - store.steampowered.com/app/XYZ)

### registerGlobalEvent

```haxe
static function registerGlobalEvent(event:Int, callb:() -> Void):Void
```

Sets the function called for a Steam callback, by its callback id (`k_iCallback` of the Steamworks structure). Used by the classes of the `steam` package.

### setNotificationPosition

```haxe
static function setNotificationPosition(pos:SteamNotificationPosition):Void
```

Not implemented: does nothing.

### sync

```haxe
static function sync():Void
```

Runs the Steam callbacks and stores the stats if requested. Called by the main loop after `init`.

### clearAchievement

```haxe
static function clearAchievement(id:String):Bool
```

* Clear an achievement
* @param   id  achievement identifier
* @return

### downloadLeaderboardScore

```haxe
static function downloadLeaderboardScore(id:String):Bool
```

Requests the score of the user in the leaderboard, received by `whenLeaderboardScoreDownloaded`. Returns `false` if Steam is not active.

### getAchievement

```haxe
static function getAchievement(id:String):Bool
```

* Returns achievement status.
* @param id Achievement API name.
* @return true, if achievement already achieved, false otherwise.

### getAchievementDescription

```haxe
static function getAchievementDescription(id:String):String
```

* Returns human-readable achievement description.
* @param id Achievement API name.
* @return UTF-8 string with achievement description.

### getAchievementName

```haxe
static function getAchievementName(id:String):String
```

* Returns human-readable achievement name.
* @param id Achievement API name.
* @return UTF-8 string with achievement name.

### getCurrentGameLanguage

```haxe
static function getCurrentGameLanguage():String
```

Returns the language selected by the user for the game (`english`, `french`...), or `null`.

### getCurrentBetaName

```haxe
static function getCurrentBetaName():String
```

Returns the name of the beta branch the user is on, or `null`.

### getStatFloat

```haxe
static function getStatFloat(id:String):Float
```

* Get a stat from steam as a float
* Kinda awkwardly returns 0 on errors and uses 0 for checking success
* @param   id
* @return

### getStatInt

```haxe
static function getStatInt(id:String):Int
```

* Get a stat from steam as an integer
* Kinda awkwardly returns 0 on errors and uses 0 for checking success
* @param   id
* @return

### getUser

```haxe
static function getUser():Null<Null<User>>
```

Returns the current user, or `null` if Steam is not active.

### indicateAchievementProgress

```haxe
static function indicateAchievementProgress(id:String, curProgress:Int, maxProgress:Int):Bool
```

Shows a progress notification for the achievement.

### isOverlayEnabled

```haxe
static function isOverlayEnabled():Bool
```

Tells if the Steam overlay is enabled.

### isDlcInstalled

```haxe
static function isDlcInstalled(appid:Int):Bool
```

Tells if the DLC of the given app id is installed.

### getAppInstallDir

```haxe
static function getAppInstallDir(appid:Int):String
```

Returns the install folder of the app, or `null`.

### isAppOwned

```haxe
static function isAppOwned(appid:Int):Bool
```

Tells if the user owns the app (from its app ownership ticket). Returns `false` if the native library doesn't have this function.

### isAppInstalled

```haxe
static function isAppInstalled(appid:Int):Bool
```

Tells if the app is installed. Returns `false` if the native library doesn't have this function.

### BOverlayNeedsPresent

```haxe
static function BOverlayNeedsPresent():Bool
```

Tells if the overlay needs the game to present a frame (when the game doesn't render continuously).

### isSteamInBigPictureMode

```haxe
static function isSteamInBigPictureMode():Bool
```

Tells if Steam runs in Big Picture mode.

### isSteamRunningOnSteamDeck

```haxe
static function isSteamRunningOnSteamDeck():Bool
```

Tells if the game runs on a Steam Deck.

### isSteamRunning

```haxe
static function isSteamRunning():Bool
```

Tells if the Steam client is running.

### openOverlay

```haxe
static function openOverlay(url:String):Void
```

Opens the web page in the Steam overlay.

### restartIfNecessary

```haxe
static function restartIfNecessary(appId:Int):Bool
```

Tells if the game was not launched by Steam: Steam then restarts it, and the game should exit. Call it before `init`.

### shutdown

```haxe
static function shutdown():Void
```

Shuts down the Steam API.

### setAchievement

```haxe
static function setAchievement(id:String):Bool
```

Unlocks the achievement. Call `storeStats` to send it.

### isAchievementHidden

```haxe
static function isAchievementHidden(id:String):Bool
```

* Returns achievement "hidden" flag.
* @param id Achievement API name.
* @return true, if achievement is flagged as hidden, false otherwise.

### getNumAchievements

```haxe
static function getNumAchievements():Int
```

* Returns amount of achievements.
* Used for iterating achievements. In general games should not need these functions because they should have a
* list of existing achievements compiled into them.

### getAchievementAPIName

```haxe
static function getAchievementAPIName(index:Int):String
```

* Returns achievement API name from its index in achievement list.
* @param index Achievement index in range [0,getNumAchievements].
* @return Achievement API name.

### setStatFloat

```haxe
static function setStatFloat(id:String, val:Float):Bool
```

* Sets a steam stat as a float
* @param   id Stat API name
* @param   val
* @return

### setStatInt

```haxe
static function setStatInt(id:String, val:Int):Bool
```

* Sets a steam stat as an int
* @param   id Stat API name
* @param   val
* @return

### storeStats

```haxe
static function storeStats():Bool
```

Sends the changed stats and achievements to the server.

### uploadLeaderboardScore

```haxe
static function uploadLeaderboardScore(score:LeaderboardScore):Bool
```

Uploads a score to its leaderboard, if it is better than the previous one (`whenLeaderboardScoreUploaded` is called). Returns `false` if Steam is not active.

### getAuthTicket

```haxe
static function getAuthTicket(?onReady:() -> Void):Bytes
```

Returns an authentication session ticket, to send to a server which checks it with Steam, or `null`. `onReady` is called with `true` when the ticket is valid, or `false` on error or after 15 seconds.

### getEncryptedAppTicket

```haxe
static function getEncryptedAppTicket(data:Bytes, onReady:() -> Void):Void
```

Requests an encrypted app ticket containing the data (or `null`), given to `onReady` (`null` on failure).

### customTrace

```haxe
static dynamic function customTrace(str:String):Void
```

Prints a log message of the API. Prints it with `Sys.println` by default.

### isSubscribed

```haxe
static function isSubscribed():Bool
```

Tells if the user owns the game (or has it through a free weekend or Family Sharing).

### isSubscribedFromFamilySharing

```haxe
static function isSubscribedFromFamilySharing():Bool
```

Tells if the user has the game through Family Sharing.

### isSubscribedFromFreeWeekend

```haxe
static function isSubscribedFromFreeWeekend():Bool
```

Tells if the user has the game through a free weekend.

### getEarliestPurchaseUnixTime

```haxe
static function getEarliestPurchaseUnixTime(appId:Int):Int
```

Returns the time of the first purchase of the app, in seconds since 1970.

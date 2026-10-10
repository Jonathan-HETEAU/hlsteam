# steam.GameServer

**class** · package [`steam`](README.md) · source [`steam/GameServer.hx`](../../../../steam/GameServer.hx)

A dedicated game server registered on Steam (Steamworks `SteamGameServer`), and the list of the servers.

## Static methods

### registerGlobalEvent

```haxe
static function registerGlobalEvent(event:Int, callb:() -> Void):Void
```

Sets the function called for a game server callback, by its callback id.

### init

```haxe
static function init(ip:sys.net.Host, port:Int, gameport:Int, queryPort:Int, serverMode:ServerMode, version:String):Bool
```

Initializes the game server on the local IP, with the game and query ports, the authentication mode and the version of the game (`port` is not used). Its callbacks are then run by the main loop. Returns `false` on failure.

### setConfig

```haxe
static function setConfig(modDir:String, product:String, desc:String):Void
```

Sets the mod folder, the product name and the game description, and marks the server as dedicated.

### setInfo

```haxe
static function setInfo(maxPlayers:Int, password:Bool, serverName:String, botCount:Int, mapName:String):Void
```

Sets the information shown in the server browser: maximum players, password protection, name, number of bots and map name.

### customTrace

```haxe
static dynamic function customTrace(str:String):Void
```

Prints a log message of the game server. Prints it with `Sys.println` by default.

### enableHeartbeats

```haxe
static function enableHeartbeats(b:Bool):Void
```

Enables the heartbeats sent to the master server, so that the server is listed.

### getPublicIP

```haxe
static function getPublicIP():Int
```

Returns the public IP of the server.

### getSteamID

```haxe
static function getSteamID():UID
```

Returns the Steam id of the server.

### logonAnonymous

```haxe
static function logonAnonymous(onLogin:() -> Void, ?retries:Int = 3):Void
```

Logs the server on Steam anonymously, retrying `retries` times: `onLogin` is called with `true` when connected, or `false` on failure. The server logs on again when disconnected.

### shutdown

```haxe
static function shutdown():Void
```

Shuts down the game server.

### requestInternetServerList

```haxe
static function requestInternetServerList(appId:Int, ?filters:{  }, ?onResults:() -> Void):Void
```

Requests the list of the internet servers of the app, with Steam server filters (field names and values): `onResults` is called with all the servers.

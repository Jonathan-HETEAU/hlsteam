# steam.Networking

**class** · package [`steam`](README.md) · source [`steam/Networking.hx`](../../../../steam/Networking.hx)

The peer-to-peer networking between users (Steamworks `ISteamNetworking`): packets are sent to a user with `sendP2P`, and received by the `NetworkApi` given to `startP2P`.

## Static variables

### USE_MULTITHREAD

```haxe
static var USE_MULTITHREAD(default, set):Bool
```

Reads the packets in a separate thread (they are still given to `onData` in the main thread). Must be set before `startP2P`.

## Static methods

### startP2P

```haxe
static function startP2P(napi:NetworkApi):Void
```

Starts receiving connections and packets with the callbacks of `napi`.

### sendP2P

```haxe
static function sendP2P(user:User, data:Bytes, type:PacketType, ?pos:Int = 0, ?len:Int = -1):Bool
```

Sends `len` bytes of `data` from `pos` (all by default) to the user, opening the connection if needed. Returns `false` on failure.

### closeSession

```haxe
static function closeSession(user:User):Void
```

Closes the connection with the user (after a short delay, so that the pending packets are sent).

### closeP2P

```haxe
static function closeP2P():Void
```

Stops receiving packets and closes all the connections.

### getSessionData

```haxe
static function getSessionData(user:User):NetworkSessionData
```

Returns the state of the connection with the user.

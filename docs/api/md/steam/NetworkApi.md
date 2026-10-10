# steam.NetworkApi

**typedef** · package [`steam`](README.md) · module `steam.Networking` · source [`steam/Networking.hx`](../../../../steam/Networking.hx)

The callbacks of the peer-to-peer networking, given to `Networking.startP2P`.

## Fields

### onData

```haxe
var onData:(u:User, data:Bytes) -> Void
```

Called when a packet was received from a user. With `Networking.USE_MULTITHREAD`, the bytes are only valid during the call.

### onConnectionRequest

```haxe
var onConnectionRequest:(u:User) -> Bool
```

Called when a user wants to connect: returns `true` to accept the connection.

### onConnectionError

```haxe
var onConnectionError:(u:User, error:NetworkStatus) -> Void
```

Called when the connection to a user failed.

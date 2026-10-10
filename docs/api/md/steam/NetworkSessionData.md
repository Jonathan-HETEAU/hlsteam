# steam.NetworkSessionData

**typedef** · package [`steam`](README.md) · module `steam.Networking` · source [`steam/Networking.hx`](../../../../steam/Networking.hx)

The state of a peer-to-peer session with a user (Steamworks `P2PSessionState_t`).

## Fields

### remotePort

```haxe
var remotePort:Int
```

The port of the remote user (if not relayed).

### remoteIP

```haxe
var remoteIP:Int
```

The IP of the remote user (if not relayed).

### relay

```haxe
var relay:Bool
```

Tells if the connection goes through a Steam relay server.

### packetSendQueue

```haxe
var packetSendQueue:Int
```

The number of packets waiting to be sent.

### error

```haxe
var error:NetworkStatus
```

The last error.

### connecting

```haxe
var connecting:Bool
```

Tells if the connection is being established.

### bytesSendQueue

```haxe
var bytesSendQueue:Int
```

The number of bytes waiting to be sent.

### alive

```haxe
var alive:Bool
```

Tells if the connection is established.

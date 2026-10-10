# steam.NetworkStatus

**enum abstract** · package [`steam`](README.md) · module `steam.Networking` · source [`steam/Networking.hx`](../../../../steam/Networking.hx)

The error of a peer-to-peer connection (Steamworks `EP2PSessionError`).

Underlying type: `Int`

## Values

| Name | Value | Description |
|---|---|---|
| `None` | `0` | No error. |
| `NotRunningApp` | `1` | The remote user is not running the same game. |
| `NoRigtsToApp` | `2` | The local user doesn't own the game. |
| `DestinationNotLoggedIn` | `3` | The remote user is not logged in to Steam. |
| `Timeout` | `4` | The connection timed out. |

# steam.PacketType

**enum abstract** · package [`steam`](README.md) · module `steam.Networking` · source [`steam/Networking.hx`](../../../../steam/Networking.hx)

How a packet is sent (Steamworks `EP2PSend`).

Underlying type: `Int`

## Values

| Name | Value | Description |
|---|---|---|
| `Unreliable` | `0` | Unreliable, can be dropped or arrive out of order (up to 1200 bytes). |
| `UnreliableNoDelay` | `1` | Unreliable, and dropped if the connection is not established yet. |
| `Reliable` | `2` | Reliable and in order (up to 1MB). |
| `ReliableWithBuffering` | `3` | Reliable, with small packets grouped together (Nagle algorithm). |

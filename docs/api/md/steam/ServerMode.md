# steam.ServerMode

**enum abstract** · package [`steam`](README.md) · module `steam.GameServer` · source [`steam/GameServer.hx`](../../../../steam/GameServer.hx)

The authentication mode of a game server (Steamworks `EServerMode`).

Underlying type: `Int`

## Values

| Name | Value | Description |
|---|---|---|
| `NoAuthentification` | `1` | No authentication of the users. |
| `Authentification` | `2` | The users are authenticated by Steam. |
| `AuthentificationAndSecure` | `3` | The users are authenticated, and the server is VAC secured. |

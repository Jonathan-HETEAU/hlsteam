# steam.ChatMessageType

**enum abstract** · package [`steam`](README.md) · module `steam.Lobby` · source [`steam/Lobby.hx`](../../../../steam/Lobby.hx)

The type of a lobby chat message (Steamworks `EChatEntryType`).

Underlying type: `Int`

## Values

| Name | Value | Description |
|---|---|---|
| `Invalid` | `0` | Invalid. |
| `ChatMsg` | `1` | Normal text message from another user |
| `Typing` | `2` | Another user is typing (not used in multi-user chat) |
| `InviteGame` | `3` | Invite from other user into that users current game |
| `LeftConversation` | `6` | user has left the conversation ( closed chat window ) |
| `Entered` | `7` | user has entered the conversation (used in multi-user chat and group chat) |
| `WasKicked` | `8` | user was kicked (data: 64-bit steamid of actor performing the kick) |
| `WasBanned` | `9` | user was banned (data: 64-bit steamid of actor performing the ban) |
| `Disconnected` | `10` | user disconnected |
| `HistoricalChat` | `11` | a chat message from user's chat history or offilne message |
| `LinkBlocked` | `14` | a link was removed by the chat filter |

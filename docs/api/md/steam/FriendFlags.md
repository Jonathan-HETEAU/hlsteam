# steam.FriendFlags

**enum abstract** · package [`steam`](README.md) · module `steam.Friends` · source [`steam/Friends.hx`](../../../../steam/Friends.hx)

The relationships to list with `Friends.getFriends` (Steamworks `EFriendFlags`), combined with `|`.

Underlying type: `Int`

## Values

| Name | Value | Description |
|---|---|---|
| `None` | `0` | None. |
| `Blocked` | `1` | Users blocked by the user. |
| `FriendshipRequested` | `2` | Users who sent a friend request. |
| `Immediate` | `4` | Regular friends. |
| `ClanMember` | `8` | Users in the same Steam groups. |
| `OnGameServer` | `0x10` | Users on the same game server. |
| `RequestingFrienship` | `0x80` | Users to whom the user sent a friend request. |
| `RequestingInfo` | `0x100` | Users whose information was requested. |
| `Ignored` | `0x200` | Ignored users. |
| `IgnoredFriend` | `0x400` | Ignored friends. |
| `ChatMember` | `0x1000` | Users in the same chats. |
| `All` | `0xFFFF` | All the relationships. |

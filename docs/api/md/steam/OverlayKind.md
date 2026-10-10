# steam.OverlayKind

**enum abstract** · package [`steam`](README.md) · module `steam.Friends` · source [`steam/Friends.hx`](../../../../steam/Friends.hx)

A dialog of the Steam overlay, opened with `Friends.activateOverlay`.

Underlying type: `String`

## Values

| Name | Value | Description |
|---|---|---|
| `None` | `"none"` | The overlay without dialog. |
| `Friends` | `"Friends"` | The friends list. |
| `Community` | `"Community"` | The Steam Community. |
| `Players` | `"Players"` | The recent players. |
| `Settings` | `"Settings"` | The Steam settings. |
| `OfficialGameGroup` | `"OfficialGameGroup"` | The Steam group of the game. |
| `Stats` | `"Stats"` | The stats of the game. |
| `Achievements` | `"Achievements"` | The achievements of the game. |
| `SteamID` | `"steamid"` | opens the overlay web browser to the specified user or groups profile |
| `Chat` | `"chat"` | opens a chat window to the specified user, or joins the group chat |
| `JoinTrade` | `"jointrade"` | opens a window to a Steam Trading session that was started with the ISteamEconomy/StartTrade Web API |
| `UserStats` | `"stats"` | opens the overlay web browser to the specified user's stats |
| `UserAchievements` | `"achievements"` | opens the overlay web browser to the specified user's achievements |
| `FriendAdd` | `"friendadd"` | opens the overlay in minimal mode prompting the user to add the target user as a friend |
| `FriendRemove` | `"friendremove"` | opens the overlay in minimal mode prompting the user to remove the target friend |
| `FriendRequestAccept` | `"friendrequestaccept"` | opens the overlay in minimal mode prompting the user to accept an incoming friend invite |
| `FriendRequestIgnore` | `"friendrequestignore"` | opens the overlay in minimal mode prompting the user to ignore an incoming friend invite |

## Methods

### toString

```haxe
function toString():String
```

Returns the Steamworks dialog name.

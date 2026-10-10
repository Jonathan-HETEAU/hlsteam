# steam.Matchmaking

**class** · package [`steam`](README.md) · source [`steam/Matchmaking.hx`](../../../../steam/Matchmaking.hx)

The lobbies: creation, search and invitations (Steamworks `ISteamMatchmaking`).

## Static methods

### requestLobbyList

```haxe
static function requestLobbyList(onLobbyList:() -> Void, ?filters:Null<LobbyListFilters>, ?resultsCount:Int):Void
```

Searches lobbies: `onLobbyList` is called with the lobbies found, or `null` on error.

### createLobby

```haxe
static function createLobby(kind:LobbyKind, maxPlayers:Int, onResult:() -> Void):AsyncCall
```

Creates a lobby, and joins it: `onResult` is called with the lobby, or `null` on error.

### checkInvite

```haxe
static function checkInvite(onInvite:() -> Void):Void
```

Sets the function called when the user accepts an invitation to a lobby, and calls it if the game was launched by an invitation (`+connect_lobby` command line argument).

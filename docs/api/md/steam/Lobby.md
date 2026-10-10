# steam.Lobby

**class** · package [`steam`](README.md) · source [`steam/Lobby.hx`](../../../../steam/Lobby.hx)

A Steam lobby: a group of users sharing key/value data and chat messages, used to gather players before a game.

## Constructor

### new

```haxe
function new(uid:UID):Void
```

Creates the lobby of the Steam id.

## Variables

### uid

```haxe
var uid(default, null):UID
```

The Steam id of the lobby.

### owner

```haxe
var owner(get, null):User
```

The owner of the lobby.

### maxMembers

```haxe
var maxMembers(get, set):Int
```

The maximum number of members.

## Methods

### set

```haxe
function set(key:String, value:Dynamic):Void
```

Sets a lobby data, serialized with `haxe.Serializer` (owner only).

### setRawData

```haxe
function setRawData(key:String, value:String):Void
```

Sets a lobby data (owner only). Throws on failure.

### remove

```haxe
function remove(key:String):Bool
```

Removes a lobby data (owner only).

### get

```haxe
function get(key:String):Dynamic
```

Returns a lobby data set with `set`, or `null`.

### getRawData

```haxe
function getRawData(key:String):Null<Null<String>>
```

Returns a lobby data, or `null`.

### getAllRaw

```haxe
function getAllRaw(?maxSize:Int = 65536):Map<String, String>
```

Returns all the lobby data. Throws if a value is larger than `maxSize` bytes.

### getAll

```haxe
function getAll(?maxSize:Int = 65536):Map<String, Dynamic>
```

Returns all the lobby data. Note: the values are currently returned as raw strings, like `getAllRaw`.

### leave

```haxe
function leave():Void
```

Leaves the lobby, and `dispose`s it.

### join

```haxe
function join(onJoin:() -> Void):AsyncCall
```

Joins the lobby: `onJoin` is called with `inviteOnly` set if only invited users can join (Steamworks `m_bLocked`), or `null` on error.

### getMembers

```haxe
function getMembers():Array<Null<User>>
```

Returns the members of the lobby (when joined).

### getMemberData

```haxe
function getMemberData(user:User, key:String):String
```

Returns a data of a member, or `null`.

### setMemberData

```haxe
function setMemberData(key:String, value:String):Void
```

Sets a data of the current user in the lobby.

### requestData

```haxe
function requestData():Bool
```

Requests the data of a lobby that was not joined: `onDataUpdated` is called when received.

### onDataUpdated

```haxe
dynamic function onDataUpdated():Void
```

Called when the lobby data changed.

### onUserDataUpdated

```haxe
dynamic function onUserDataUpdated(user:User):Void
```

Called when the data of a member changed.

### onUserJoined

```haxe
dynamic function onUserJoined(user:User):Void
```

Called when a user joined the lobby.

### onUserLeft

```haxe
dynamic function onUserLeft(user:User):Void
```

Called when a user left the lobby (or disconnected, was kicked or banned).

### onChatMessage

```haxe
dynamic function onChatMessage(type:ChatMessageType, cid:Int):Void
```

Called when a chat message was received: read it with `getChatEntry(cid)`.

### getChatEntry

```haxe
function getChatEntry(cid:Int, ?maxData:Int = 1024):{ user:User, type:ChatMessageType, data:Bytes }
```

Returns a chat message: its sender, data (at most `maxData` bytes) and type.

### sendChatMessage

```haxe
function sendChatMessage(bytes:Bytes):Void
```

Sends a chat message to the members. Throws on failure.

### inviteFriends

```haxe
function inviteFriends():Void
```

Opens the Steam overlay to invite friends to the lobby.

### inviteUser

```haxe
function inviteUser(user:User):Bool
```

Invites a user to the lobby.

### toString

```haxe
function toString():String
```

Returns a description of the lobby.

### dispose

```haxe
function dispose():Void
```

Stops the callbacks of the lobby.

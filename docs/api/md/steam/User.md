# steam.User

**class** · package [`steam`](README.md) · source [`steam/User.hx`](../../../../steam/User.hx)

A Steam user. Users are unique for a UID: get them with `fromUID`.

## Static methods

### fromUID

```haxe
static function fromUID(uid:UID):Null<User>
```

Returns the user of the Steam id.

### fromUID32

```haxe
static function fromUID32(uid:Int):Null<User>
```

Returns the user of the account id returned by `getID32` (an individual account of the public universe).

## Variables

### uid

```haxe
var uid(default, null):UID
```

The Steam id of the user.

### name

```haxe
var name(get, null):String
```

The name of the user (cached once read). Can be unknown until `requestInformation` completes.

## Methods

### getID32

```haxe
function getID32():Int
```

Returns the lower 32 bits of the Steam id (the account id), see `fromUID32`.

### requestInformation

```haxe
function requestInformation(onChange:() -> Void, ?nameOnly:Bool = false):Void
```

Requests the name and avatar (or only the name) of the user: `onChange` is called with the changed information when received.

### toString

```haxe
function toString():String
```

Returns the name and the UID of the user.

### getAvatar

```haxe
function getAvatar(size:AvatarSize):{ width:Int, rgba:Bytes, height:Int }
```

Returns the avatar of the user as RGBA pixels, or `null` if not loaded yet (see `requestInformation`).

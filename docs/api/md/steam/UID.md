# steam.UID

**abstract** · package [`steam`](README.md) · source [`steam/UID.hx`](../../../../steam/UID.hx)

A 64 bits Steam identifier (`CSteamID`: user, lobby, game server...) or Workshop file identifier, stored as 8 bytes.

Underlying type: `hl.Bytes`

## Static methods

### fromBytes

```haxe
static function fromBytes(bytes:Bytes):UID
```

Returns the identifier from its 8 bytes. Throws if the length is not 8.

### fromInt64

```haxe
static function fromInt64(v:Int64):UID
```

Returns the identifier from a 64 bits integer.

## Methods

### toString

```haxe
function toString():String
```

Returns the identifier in hexadecimal.

### getBytes

```haxe
function getBytes():Bytes
```

Returns the 8 bytes of the identifier.

### getInt64

```haxe
function getInt64():Int64
```

Returns the identifier as a 64 bits integer.

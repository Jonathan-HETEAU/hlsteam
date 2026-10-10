# steam.Cloud

**class** · package [`steam`](README.md) · source [`steam/Cloud.hx`](../../../../steam/Cloud.hx)

Steam Cloud: the files of the user stored by Steam and synchronized between computers (Steamworks `ISteamRemoteStorage`).

## Static methods

### count

```haxe
static function count():Int
```

Returns the number of files.

### exists

```haxe
static function exists(name:String):Bool
```

Tells if the file exists.

### size

```haxe
static function size(name:String):Int
```

Returns the size of the file, in bytes.

### quota

```haxe
static function quota():{ total:Float, available:Float }
```

Returns the total and available space, in bytes.

### read

```haxe
static function read(name:String):Bytes
```

Returns the content of the file, or `null` if it doesn't exist.

### share

```haxe
static function share(name:String, onResult:() -> Void):AsyncCall
```

Shares the file publicly: `onResult` is called with the UID of the shared file, or `null` on error.

### write

```haxe
static function write(name:String, data:Bytes):Bool
```

Writes the file. Returns `false` on error.

### delete

```haxe
static function delete(name:String):Bool
```

Deletes the file. Returns `false` on error.

### isEnabled

```haxe
static function isEnabled():Bool
```

Tells if Steam Cloud is enabled for the game and for the account.

### isEnabledForApp

```haxe
static function isEnabledForApp():Bool
```

Tells if the user enabled Steam Cloud for the game.

### isEnabledForAccount

```haxe
static function isEnabledForAccount():Bool
```

Tells if Steam Cloud is enabled for the account.

### enable

```haxe
static function enable(b:Bool):Void
```

Enables or disables Steam Cloud for the game.

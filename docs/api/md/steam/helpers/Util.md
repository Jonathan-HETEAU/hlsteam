# steam.helpers.Util

**class** · package [`steam.helpers`](README.md) · source [`steam/helpers/Util.hx`](../../../../../steam/helpers/Util.hx)

String conversion helpers.

## Static methods

### boolify

```haxe
static function boolify(str:String):Bool
```

Returns `true` for `1` or `true` (any case), `false` otherwise.

### str2Float

```haxe
static function str2Float(str:String, ?defaultValue:Float = 0.0):Float
```

Parses a float, or returns `defaultValue`.

### str2Int

```haxe
static function str2Int(str:String, ?defaultValue:Int = 0):Int
```

Parses an integer, or returns `defaultValue`.

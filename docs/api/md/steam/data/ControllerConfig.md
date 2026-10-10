# steam.data.ControllerConfig

**class** · package [`steam.data`](README.md) · source [`steam/data/ControllerConfig.hx`](../../../../../steam/data/ControllerConfig.hx)

* A strongly-typed data structure representation of the "game_actions_xyz.vdf"
* file Steam uses to define controller inputs for your game. You can initialize
* this from a VDF string, JSON string, or generic data structure
* 
* @author

## Constructor

### new

```haxe
function new():Void
```

Creates an empty configuration.

## Static methods

### fromVDF

```haxe
static function fromVDF(str:String):ControllerConfig
```

Reads the configuration from the VDF file.

### fromJSON

```haxe
static function fromJSON(str:String):ControllerConfig
```

Reads the configuration from the VDF file converted to JSON.

### fromObject

```haxe
static function fromObject(obj:Dynamic):ControllerConfig
```

Reads the configuration from the parsed VDF file. Throws if the `In Game Actions` or `actions` sections are missing.

## Variables

### actionSets

```haxe
var actionSets:Array<ControllerActionSet>
```

The action sets.

### localizations

```haxe
var localizations:Array<ControllerLocalization>
```

The localized texts, by language.

## Methods

### toString

```haxe
function toString():String
```

Returns a description of the configuration.

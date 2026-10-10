# steam.ControllerMotionData

**class** · package [`steam`](README.md) · module `steam.Controller` · source [`steam/Controller.hx`](../../../../steam/Controller.hx)

The motion data of a controller.

## Constructor

### new

```haxe
function new():Void
```

Creates empty data.

## Variables

### rotQuatX

```haxe
var rotQuatX:Float
```

The X of the sensor-fused absolute rotation quaternion (drifts in heading).

### rotQuatY

```haxe
var rotQuatY:Float
```

The Y of the absolute rotation quaternion.

### rotQuatZ

```haxe
var rotQuatZ:Float
```

The Z of the absolute rotation quaternion.

### rotQuatW

```haxe
var rotQuatW:Float
```

The W of the absolute rotation quaternion.

### posAccelX

```haxe
var posAccelX:Float
```

The X positional acceleration.

### posAccelY

```haxe
var posAccelY:Float
```

The Y positional acceleration.

### posAccelZ

```haxe
var posAccelZ:Float
```

The Z positional acceleration.

### rotVelX

```haxe
var rotVelX:Float
```

The X angular velocity.

### rotVelY

```haxe
var rotVelY:Float
```

The Y angular velocity.

### rotVelZ

```haxe
var rotVelZ:Float
```

The Z angular velocity.

## Methods

### toString

```haxe
function toString():String
```

Returns a description of the data.

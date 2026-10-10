# steam.EControllerActionOrigin

**enum abstract** · package [`steam`](README.md) · module `steam.Controller` · source [`steam/Controller.hx`](../../../../steam/Controller.hx)

A physical input of a controller bound to an action (Steamworks `EControllerActionOrigin`). Converts from a number or a name (`"XBOXONE_A"`), and to its name.

Underlying type: `Int`

Implicit casts from: `String`

Implicit casts to: `Int`, `String`

## Values

| Name | Value | Description |
|---|---|---|
| `NONE` | `0` | No origin. |
| `A` | `1` | Steam Controller: A button. |
| `B` | `2` | Steam Controller: B button. |
| `X` | `3` | Steam Controller: X button. |
| `Y` | `4` | Steam Controller: Y button. |
| `LEFTBUMPER` | `5` | Steam Controller: left bumper. |
| `RIGHTBUMPER` | `6` | Steam Controller: right bumper. |
| `LEFTGRIP` | `7` | Steam Controller: left grip. |
| `RIGHTGRIP` | `8` | Steam Controller: right grip. |
| `START` | `9` | Steam Controller: start button. |
| `BACK` | `10` | Steam Controller: back button. |
| `LEFTPAD_TOUCH` | `11` | Steam Controller: left trackpad, touch. |
| `LEFTPAD_SWIPE` | `12` | Steam Controller: left trackpad, swipe. |
| `LEFTPAD_CLICK` | `13` | Steam Controller: left trackpad, click. |
| `LEFTPAD_DPADNORTH` | `14` | Steam Controller: left trackpad, up. |
| `LEFTPAD_DPADSOUTH` | `15` | Steam Controller: left trackpad, down. |
| `LEFTPAD_DPADWEST` | `16` | Steam Controller: left trackpad, left. |
| `LEFTPAD_DPADEAST` | `17` | Steam Controller: left trackpad, right. |
| `RIGHTPAD_TOUCH` | `18` | Steam Controller: right trackpad, touch. |
| `RIGHTPAD_SWIPE` | `19` | Steam Controller: right trackpad, swipe. |
| `RIGHTPAD_CLICK` | `20` | Steam Controller: right trackpad, click. |
| `RIGHTPAD_DPADNORTH` | `21` | Steam Controller: right trackpad, up. |
| `RIGHTPAD_DPADSOUTH` | `22` | Steam Controller: right trackpad, down. |
| `RIGHTPAD_DPADWEST` | `23` | Steam Controller: right trackpad, left. |
| `RIGHTPAD_DPADEAST` | `24` | Steam Controller: right trackpad, right. |
| `LEFTTRIGGER_PULL` | `25` | Steam Controller: left trigger, pull. |
| `LEFTTRIGGER_CLICK` | `26` | Steam Controller: left trigger, click. |
| `RIGHTTRIGGER_PULL` | `27` | Steam Controller: right trigger, pull. |
| `RIGHTTRIGGER_CLICK` | `28` | Steam Controller: right trigger, click. |
| `LEFTSTICK_MOVE` | `29` | Steam Controller: left stick, move. |
| `LEFTSTICK_CLICK` | `30` | Steam Controller: left stick, click. |
| `LEFTSTICK_DPADNORTH` | `31` | Steam Controller: left stick, up. |
| `LEFTSTICK_DPADSOUTH` | `32` | Steam Controller: left stick, down. |
| `LEFTSTICK_DPADWEST` | `33` | Steam Controller: left stick, left. |
| `LEFTSTICK_DPADEAST` | `34` | Steam Controller: left stick, right. |
| `GYRO_MOVE` | `35` | Steam Controller: gyro, move. |
| `GYRO_PITCH` | `36` | Steam Controller: gyro, pitch. |
| `GYRO_YAW` | `37` | Steam Controller: gyro, yaw. |
| `GYRO_ROLL` | `38` | Steam Controller: gyro, roll. |
| `PS4_X` | `39` | PS4 controller: cross button. |
| `PS4_CIRCLE` | `40` | PS4 controller: circle button. |
| `PS4_TRIANGLE` | `41` | PS4 controller: triangle button. |
| `PS4_SQUARE` | `42` | PS4 controller: square button. |
| `PS4_LEFTBUMPER` | `43` | PS4 controller: left bumper. |
| `PS4_RIGHTBUMPER` | `44` | PS4 controller: right bumper. |
| `PS4_OPTIONS` | `45` | PS4 controller: Options button. |
| `PS4_SHARE` | `46` | PS4 controller: Share button. |
| `PS4_LEFTPAD_TOUCH` | `47` | PS4 controller: left trackpad, touch. |
| `PS4_LEFTPAD_SWIPE` | `48` | PS4 controller: left trackpad, swipe. |
| `PS4_LEFTPAD_CLICK` | `49` | PS4 controller: left trackpad, click. |
| `PS4_LEFTPAD_DPADNORTH` | `50` | PS4 controller: left trackpad, up. |
| `PS4_LEFTPAD_DPADSOUTH` | `51` | PS4 controller: left trackpad, down. |
| `PS4_LEFTPAD_DPADWEST` | `52` | PS4 controller: left trackpad, left. |
| `PS4_LEFTPAD_DPADEAST` | `53` | PS4 controller: left trackpad, right. |
| `PS4_RIGHTPAD_TOUCH` | `54` | PS4 controller: right trackpad, touch. |
| `PS4_RIGHTPAD_SWIPE` | `55` | PS4 controller: right trackpad, swipe. |
| `PS4_RIGHTPAD_CLICK` | `56` | PS4 controller: right trackpad, click. |
| `PS4_RIGHTPAD_DPADNORTH` | `57` | PS4 controller: right trackpad, up. |
| `PS4_RIGHTPAD_DPADSOUTH` | `58` | PS4 controller: right trackpad, down. |
| `PS4_RIGHTPAD_DPADWEST` | `59` | PS4 controller: right trackpad, left. |
| `PS4_RIGHTPAD_DPADEAST` | `60` | PS4 controller: right trackpad, right. |
| `PS4_CENTERPAD_TOUCH` | `61` | PS4 controller: center trackpad, touch. |
| `PS4_CENTERPAD_SWIPE` | `62` | PS4 controller: center trackpad, swipe. |
| `PS4_CENTERPAD_CLICK` | `63` | PS4 controller: center trackpad, click. |
| `PS4_CENTERPAD_DPADNORTH` | `64` | PS4 controller: center trackpad, up. |
| `PS4_CENTERPAD_DPADSOUTH` | `65` | PS4 controller: center trackpad, down. |
| `PS4_CENTERPAD_DPADWEST` | `66` | PS4 controller: center trackpad, left. |
| `PS4_CENTERPAD_DPADEAST` | `67` | PS4 controller: center trackpad, right. |
| `PS4_LEFTTRIGGER_PULL` | `68` | PS4 controller: left trigger, pull. |
| `PS4_LEFTTRIGGER_CLICK` | `69` | PS4 controller: left trigger, click. |
| `PS4_RIGHTTRIGGER_PULL` | `70` | PS4 controller: right trigger, pull. |
| `PS4_RIGHTTRIGGER_CLICK` | `71` | PS4 controller: right trigger, click. |
| `PS4_LEFTSTICK_MOVE` | `72` | PS4 controller: left stick, move. |
| `PS4_LEFTSTICK_CLICK` | `73` | PS4 controller: left stick, click. |
| `PS4_LEFTSTICK_DPADNORTH` | `74` | PS4 controller: left stick, up. |
| `PS4_LEFTSTICK_DPADSOUTH` | `75` | PS4 controller: left stick, down. |
| `PS4_LEFTSTICK_DPADWEST` | `76` | PS4 controller: left stick, left. |
| `PS4_LEFTSTICK_DPADEAST` | `77` | PS4 controller: left stick, right. |
| `PS4_RIGHTSTICK_MOVE` | `78` | PS4 controller: right stick, move. |
| `PS4_RIGHTSTICK_CLICK` | `79` | PS4 controller: right stick, click. |
| `PS4_RIGHTSTICK_DPADNORTH` | `80` | PS4 controller: right stick, up. |
| `PS4_RIGHTSTICK_DPADSOUTH` | `81` | PS4 controller: right stick, down. |
| `PS4_RIGHTSTICK_DPADWEST` | `82` | PS4 controller: right stick, left. |
| `PS4_RIGHTSTICK_DPADEAST` | `83` | PS4 controller: right stick, right. |
| `PS4_DPAD_NORTH` | `84` | PS4 controller: D-pad, up. |
| `PS4_DPAD_SOUTH` | `85` | PS4 controller: D-pad, down. |
| `PS4_DPAD_WEST` | `86` | PS4 controller: D-pad, left. |
| `PS4_DPAD_EAST` | `87` | PS4 controller: D-pad, right. |
| `PS4_GYRO_MOVE` | `88` | PS4 controller: gyro, move. |
| `PS4_GYRO_PITCH` | `89` | PS4 controller: gyro, pitch. |
| `PS4_GYRO_YAW` | `90` | PS4 controller: gyro, yaw. |
| `PS4_GYRO_ROLL` | `91` | PS4 controller: gyro, roll. |
| `XBOXONE_A` | `92` | Xbox One controller: A button. |
| `XBOXONE_B` | `93` | Xbox One controller: B button. |
| `XBOXONE_X` | `94` | Xbox One controller: X button. |
| `XBOXONE_Y` | `95` | Xbox One controller: Y button. |
| `XBOXONE_LEFTBUMPER` | `96` | Xbox One controller: left bumper. |
| `XBOXONE_RIGHTBUMPER` | `97` | Xbox One controller: right bumper. |
| `XBOXONE_MENU` | `98` | Xbox One controller: Menu button. |
| `XBOXONE_VIEW` | `99` | Xbox One controller: View button. |
| `XBOXONE_LEFTTRIGGER_PULL` | `100` | Xbox One controller: left trigger, pull. |
| `XBOXONE_LEFTTRIGGER_CLICK` | `101` | Xbox One controller: left trigger, click. |
| `XBOXONE_RIGHTTRIGGER_PULL` | `102` | Xbox One controller: right trigger, pull. |
| `XBOXONE_RIGHTTRIGGER_CLICK` | `103` | Xbox One controller: right trigger, click. |
| `XBOXONE_LEFTSTICK_MOVE` | `104` | Xbox One controller: left stick, move. |
| `XBOXONE_LEFTSTICK_CLICK` | `105` | Xbox One controller: left stick, click. |
| `XBOXONE_LEFTSTICK_DPADNORTH` | `106` | Xbox One controller: left stick, up. |
| `XBOXONE_LEFTSTICK_DPADSOUTH` | `107` | Xbox One controller: left stick, down. |
| `XBOXONE_LEFTSTICK_DPADWEST` | `108` | Xbox One controller: left stick, left. |
| `XBOXONE_LEFTSTICK_DPADEAST` | `109` | Xbox One controller: left stick, right. |
| `XBOXONE_RIGHTSTICK_MOVE` | `110` | Xbox One controller: right stick, move. |
| `XBOXONE_RIGHTSTICK_CLICK` | `111` | Xbox One controller: right stick, click. |
| `XBOXONE_RIGHTSTICK_DPADNORTH` | `112` | Xbox One controller: right stick, up. |
| `XBOXONE_RIGHTSTICK_DPADSOUTH` | `113` | Xbox One controller: right stick, down. |
| `XBOXONE_RIGHTSTICK_DPADWEST` | `114` | Xbox One controller: right stick, left. |
| `XBOXONE_RIGHTSTICK_DPADEAST` | `115` | Xbox One controller: right stick, right. |
| `XBOXONE_DPAD_NORTH` | `116` | Xbox One controller: D-pad, up. |
| `XBOXONE_DPAD_SOUTH` | `117` | Xbox One controller: D-pad, down. |
| `XBOXONE_DPAD_WEST` | `118` | Xbox One controller: D-pad, left. |
| `XBOXONE_DPAD_EAST` | `119` | Xbox One controller: D-pad, right. |
| `XBOX360_A` | `120` | Xbox 360 controller: A button. |
| `XBOX360_B` | `121` | Xbox 360 controller: B button. |
| `XBOX360_X` | `122` | Xbox 360 controller: X button. |
| `XBOX360_Y` | `123` | Xbox 360 controller: Y button. |
| `XBOX360_LEFTBUMPER` | `124` | Xbox 360 controller: left bumper. |
| `XBOX360_RIGHTBUMPER` | `125` | Xbox 360 controller: right bumper. |
| `XBOX360_START` | `126` | Xbox 360 controller: start button. |
| `XBOX360_BACK` | `127` | Xbox 360 controller: back button. |
| `XBOX360_LEFTTRIGGER_PULL` | `128` | Xbox 360 controller: left trigger, pull. |
| `XBOX360_LEFTTRIGGER_CLICK` | `129` | Xbox 360 controller: left trigger, click. |
| `XBOX360_RIGHTTRIGGER_PULL` | `130` | Xbox 360 controller: right trigger, pull. |
| `XBOX360_RIGHTTRIGGER_CLICK` | `131` | Xbox 360 controller: right trigger, click. |
| `XBOX360_LEFTSTICK_MOVE` | `132` | Xbox 360 controller: left stick, move. |
| `XBOX360_LEFTSTICK_CLICK` | `133` | Xbox 360 controller: left stick, click. |
| `XBOX360_LEFTSTICK_DPADNORTH` | `134` | Xbox 360 controller: left stick, up. |
| `XBOX360_LEFTSTICK_DPADSOUTH` | `135` | Xbox 360 controller: left stick, down. |
| `XBOX360_LEFTSTICK_DPADWEST` | `136` | Xbox 360 controller: left stick, left. |
| `XBOX360_LEFTSTICK_DPADEAST` | `137` | Xbox 360 controller: left stick, right. |
| `XBOX360_RIGHTSTICK_MOVE` | `138` | Xbox 360 controller: right stick, move. |
| `XBOX360_RIGHTSTICK_CLICK` | `139` | Xbox 360 controller: right stick, click. |
| `XBOX360_RIGHTSTICK_DPADNORTH` | `140` | Xbox 360 controller: right stick, up. |
| `XBOX360_RIGHTSTICK_DPADSOUTH` | `141` | Xbox 360 controller: right stick, down. |
| `XBOX360_RIGHTSTICK_DPADWEST` | `142` | Xbox 360 controller: right stick, left. |
| `XBOX360_RIGHTSTICK_DPADEAST` | `143` | Xbox 360 controller: right stick, right. |
| `XBOX360_DPAD_NORTH` | `144` | Xbox 360 controller: D-pad, up. |
| `XBOX360_DPAD_SOUTH` | `145` | Xbox 360 controller: D-pad, down. |
| `XBOX360_DPAD_WEST` | `146` | Xbox 360 controller: D-pad, left. |
| `XBOX360_DPAD_EAST` | `147` | Xbox 360 controller: D-pad, right. |
| `COUNT` | `148` | The number of origins. |
| `UNKNOWN` | `-1` | An unknown origin. |

## Static variables

### fromStringMap

```haxe
static var fromStringMap(default, null):Map<String, EControllerActionOrigin>
```

The origins by name.

### toStringMap

```haxe
static var toStringMap(default, null):Map<EControllerActionOrigin, String>
```

The names by origin.

## Static methods

### getGlyph

```haxe
static function getGlyph(value:EControllerActionOrigin):String
```

* Returns the string name for this glyph so you can load a corresponding image from your assets.
* @param   value the integer value of a controller action origin from the steam API
* @return  a unique string identifier for this glyph, OR "unknown" if the glyph is not known (see Controller.getGlyphForActionOrigin())

## Methods

### toString

```haxe
inline function toString():String
```

Returns the name of the origin, or `unknown`.

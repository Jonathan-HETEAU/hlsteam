# steam.Controller

**class** · package [`steam`](README.md) · source [`steam/Controller.hx`](../../../../steam/Controller.hx)

* The Steam Controller API. Used by API.hx, should never be created manually by the user.
* API.hx creates and initializes this by default.
* Access it via API.controller static variable

## Static variables

### MAX_SINGLE_PULSE_TIME

```haxe
static inline var MAX_SINGLE_PULSE_TIME:Int = 65535
```

The maximum duration of a single haptic pulse, in microseconds.

## Variables

### MAX_CONTROLLERS

```haxe
var MAX_CONTROLLERS(get, null):Int
```

* The maximum number of controllers steam can recognize. Use this for array upper bounds.

### MAX_ANALOG_ACTIONS

```haxe
var MAX_ANALOG_ACTIONS(get, null):Int
```

* The maximum number of analog actions steam can recognize. Use this for array upper bounds.

### MAX_DIGITAL_ACTIONS

```haxe
var MAX_DIGITAL_ACTIONS(get, null):Int
```

* The maximum number of digital actions steam can recognize. Use this for array upper bounds.

### MAX_ORIGINS

```haxe
var MAX_ORIGINS(get, null):Int
```

* The maximum number of origins steam can assign to one action. Use this for array upper bounds.

### MAX_ANALOG_VALUE

```haxe
var MAX_ANALOG_VALUE(get, null):Float
```

* The maximum value steam will report for an analog action.

### MIN_ANALOG_VALUE

```haxe
var MIN_ANALOG_VALUE(get, null):Float
```

* The minimum value steam will report for an analog action.

### active

```haxe
var active(default, null):Bool
```

* Whether the controller API is initialized or not. If false, all calls will fail.

## Methods

### activateActionSet

```haxe
function activateActionSet(controller:Int, actionSet:Int):Void
```

* Reconfigure the controller to use the specified action set (ie 'Menu', 'Walk' or 'Drive')
* This is cheap, and can be safely called repeatedly. It's often easier to repeatedly call it in
* your state loops, instead of trying to place it in all of your state transitions.
*
* @param   controller  handle received from getConnectedControllers()
* @param   actionSet   handle received from getActionSetHandle()
* @return  1 = success, 0 = failure

### getCurrentActionSet

```haxe
function getCurrentActionSet(controller:Int):Int
```

* Get the handle of the current action set
*
* @param   controller  handle received from getConnectedControllers()
* @return  handle of the current action set

### getActionSetHandle

```haxe
function getActionSetHandle(name:String):Int
```

* Lookup the handle for an Action Set. Best to do this once on startup, and store the handles for all future API calls.
*
* @param   name identifier for the action set specified in your vdf file (ie, 'Menu', 'Walk' or 'Drive')
* @return  action set handle

### getAnalogActionData

```haxe
function getAnalogActionData(controller:Int, action:Int, ?data:ControllerAnalogActionData):ControllerAnalogActionData
```

* Returns the current state of the supplied analog game action
*
* @param   controller  handle received from getConnectedControllers()
* @param   action  handle received from getActionSetHandle()
* @param   data    existing ControllerAnalogActionData structure you want to fill (optional)
* @return  data structure containing analog x,y values & other data

### getAnalogActionHandle

```haxe
function getAnalogActionHandle(name:String):Int
```

* Lookup the handle for an analog (continuos range) action. Best to do this once on startup, and store the handles for all future API calls.
*
* @param   name    identifier for the action specified in your vdf file (ie, 'Jump', 'Fire', or 'Move')
* @return  action analog action handle

### getAnalogActionOrigins

```haxe
function getAnalogActionOrigins(controller:Int, actionSet:Int, action:Int, ?originsOut:Array<EControllerActionOrigin>):Int
```

* Get the origin(s) for an analog action with an action set. Use this to display the appropriate on-screen prompt for the action.
* NOTE: Users can change their action origins at any time, and Valve says this is a cheap call and recommends you poll it continuosly
* to update your on-screen glyph visuals, rather than calling it rarely and caching the values.
*
* @param   controller  handle received from getConnectedControllers()
* @param   actionSet   handle received from getActionSetHandle()
* @param   action  handle received from getAnalogActionHandle()
* @param   originsOut  existing array of EControllerActionOrigins you want to fill (optional)
* @return the number of origins supplied in originsOut.

### getConnectedControllers

```haxe
function getConnectedControllers():Array<Int>
```

* Enumerate currently connected controllers
*
* NOTE: the native steam controller handles are uint64's and too large to easily pass to Haxe,
* so the "true" values are left on the C++ side and haxe only deals with 0-based integer indeces
* that map back to the "true" values on the C++ side
*
* @return controller handles

### getDigitalActionData

```haxe
function getDigitalActionData(controller:Int, action:Int):ControllerDigitalActionData
```

* Returns the current state of the supplied digital game action
*
* @param   controller  handle received from getConnectedControllers()
* @param   action  handle received from getDigitalActionHandle()
* @return

### getDigitalActionHandle

```haxe
function getDigitalActionHandle(name:String):Int
```

* Lookup the handle for a digital (true/false) action. Best to do this once on startup, and store the handles for all future API calls.
*
* @param   name    identifier for the action specified in your vdf file (ie, 'Jump', 'Fire', or 'Move')
* @return  digital action handle

### getDigitalActionOrigins

```haxe
function getDigitalActionOrigins(controller:Int, actionSet:Int, action:Int, ?originsOut:Array<EControllerActionOrigin>):Int
```

* Get the origin(s) for a digital action with an action set. Use this to display the appropriate on-screen prompt for the action.
*
* @param   controller  handle received from getConnectedControllers()
* @param   actionSet   handle received from getActionSetHandle()
* @param   action  handle received from getDigitalActionHandle()
* @param   originsOut  existing array of EControllerActionOrigins you want to fill (optional)
* @return the number of origins supplied in originsOut.

### getGlyphForActionOrigin

```haxe
function getGlyphForActionOrigin(origin:EControllerActionOrigin):String
```

* Get a local path to art for on-screen glyph for a particular origin
* @param   origin
* @return

### getStringForActionOrigin

```haxe
function getStringForActionOrigin(origin:EControllerActionOrigin):String
```

* Returns a localized string (from Steam's language setting) for the specified origin
* @param   origin
* @return

### showBindingPanel

```haxe
function showBindingPanel(controller:Int):Bool
```

* Activates the Steam overlay and shows the input configuration (binding) screen
* @return false if overlay is disabled / unavailable, or if the Steam client is not in Big Picture mode

### showGamepadTextInput

```haxe
function showGamepadTextInput(inputMode:EGamepadTextInputMode, lineMode:EGamepadTextInputLineMode, description:String, ?charMax:Int = 0xFFFFFF, ?existingText:String = ""):Bool
```

* Activates the Big Picture text input dialog which only supports gamepad input
* @param   inputMode   NORMAL or PASSWORD
* @param   lineMode    SINGLE_LINE or MULTIPLE_LINES
* @param   description User-facing description of what's being entered, e.g. "Please enter your name"
* @param   charMax Maximum number of characters
* @param   existingText    Text to pre-fill the dialog with, if any
* @return

### getEnteredGamepadTextInput

```haxe
function getEnteredGamepadTextInput():String
```

* Returns the text that the player has entered using showGamepadTextInput()
* @return

### shutdown

```haxe
function shutdown():Void
```

* Must be called when ending use of this API

### hapticPulseRumble

```haxe
function hapticPulseRumble(controller:Int, targetPad:ESteamControllerPad, durationMilliSec:Int, strength:Float):Void
```

* Trigger a haptic pulse in a slightly friendlier way
* @param   controller  handle received from getConnectedControllers()
* @param   targetPad   which pad you want to pulse
* @param   durationMilliSec    duration of the pulse, in milliseconds (1/1000 sec)
* @param   strength    value between 0 and 1, general intensity of the pulsing

### triggerHapticPulse

```haxe
function triggerHapticPulse(controller:Int, targetPad:ESteamControllerPad, durationMicroSec:Int):Void
```

* Trigger a single haptic pulse (low-level)
* @param   controller  handle received from getConnectedControllers()
* @param   targetPad   which pad you want to pulse
* @param   durationMicroSec    duration of the pulse, in microseconds (1/1000 ms)

### triggerRepeatedHapticPulse

```haxe
function triggerRepeatedHapticPulse(controller:Int, targetPad:ESteamControllerPad, durationMicroSec:Int, offMicroSec:Int, repeat:Int, flags:Int):Void
```

* Trigger a repeated haptic pulse (low-level)
* @param   controller  handle received from getConnectedControllers()
* @param   targetPad   which pad you want to pulse
* @param   durationMicroSec    duration of the pulse, in microseconds (1/1,000 ms)
* @param   offMicroSec offset between pulses, in microseconds (1/1,000 ms)
* @param   repeat  number of pulses
* @param   flags   special behavior flags

### triggerVibration

```haxe
function triggerVibration(controller:Int, leftSpeed:Int, rightSpeed:Int):Void
```

* Trigger a vibration event on supported controllers
* @param   controller  handle received from getConnectedControllers()
* @param   leftSpeed   how fast the left motor should vibrate (0-65,535)
* @param   rightSpeed  how fast the right motor should vibrate (0-65,535)

### setLEDColor

```haxe
function setLEDColor(controller:Int, rgb:Int, ?flags:Int = ESteamControllerLEDFlags.SET_COLOR):Void
```

* Set the controller LED color on supported controllers.
* @param   controller  handle received from getConnectedControllers()
* @param   rgb an RGB color in 0xRRGGBB format
* @param   flags   bit-masked flags combined from values defined in ESteamControllerLEDFlags

### resetLEDColor

```haxe
function resetLEDColor(controller:Int):Void
```

Restores the LED color set by the user.

### getGamepadIndexForController

```haxe
function getGamepadIndexForController(controller:Int):Int
```

Returns the XInput gamepad index of the controller, or `-1` if it is not emulating a gamepad.

### getControllerForGamepadIndex

```haxe
function getControllerForGamepadIndex(index:Int):Int
```

Returns the controller emulating the XInput gamepad index.

### getMotionData

```haxe
function getMotionData(controller:Int, ?data:ControllerMotionData):ControllerMotionData
```

* Returns the current state of the supplied analog game action
*
* @param   controller  handle received from getConnectedControllers()
* @param   data    existing ControllerMotionData structure you want to fill (optional)
* @return  data structure containing motion data values

### showDigitalActionOrigins

```haxe
function showDigitalActionOrigins(controller:Int, digitalActionHandle:Int, scale:Float, xPosition:Float, yPosition:Float):Void
```

* Attempt to display origins of given action in the controller HUD, for the currently active action set
* Returns false is overlay is disabled / unavailable, or the user is not in Big Picture mode
* @param   controller  handle received from getConnectedControllers()
* @param   digitalActionHandle handle received from getDigitalActionHandle()
* @param   scale   scale multiplier to apply to the on-screen display (1.0 is 1:1 size)
* @param   xPosition   position of the on-screen display (0.5 is the center)
* @param   yPosition   position of the on-screen display (0.5 is the center)

### showAnalogActionOrigins

```haxe
function showAnalogActionOrigins(controller:Int, analogActionHandle:Int, scale:Float, xPosition:Float, yPosition:Float):Void
```

* Attempt to display origins of given action in the controller HUD, for the currently active action set
* Returns false is overlay is disabled / unavailable, or the user is not in Big Picture mode
* @param   controller  handle received from getConnectedControllers()
* @param   analogActionHandle  handle received from getDigitalActionHandle()
* @param   scale   scale multiplier to apply to the on-screen display (1.0 is 1:1 size)
* @param   xPosition   position of the on-screen display (0.5 is the center)
* @param   yPosition   position of the on-screen display (0.5 is the center)

package steam;
import steam.helpers.MacroHelper;

/**
 * The Steam Controller API. Used by API.hx, should never be created manually by the user.
 * API.hx creates and initializes this by default.
 * Access it via API.controller static variable
 */

@:allow(steam.Api)
class Controller
{
	/**
	 * The maximum number of controllers steam can recognize. Use this for array upper bounds.
	 */
	public var MAX_CONTROLLERS(get, null):Int;

	/**
	 * The maximum number of analog actions steam can recognize. Use this for array upper bounds.
	 */
	public var MAX_ANALOG_ACTIONS(get, null):Int;

	/**
	 * The maximum number of digital actions steam can recognize. Use this for array upper bounds.
	 */
	public var MAX_DIGITAL_ACTIONS(get, null):Int;

	/**
	 * The maximum number of origins steam can assign to one action. Use this for array upper bounds.
	 */
	public var MAX_ORIGINS(get, null):Int;

	/**
	 * The maximum value steam will report for an analog action.
	 */
	public var MAX_ANALOG_VALUE(get, null):Float;

	/**
	 * The minimum value steam will report for an analog action.
	 */
	public var MIN_ANALOG_VALUE(get, null):Float;

	/**
		The maximum duration of a single haptic pulse, in microseconds.
	**/
	public static inline var MAX_SINGLE_PULSE_TIME:Int = 65535;

	/*************PUBLIC***************/

	/**
	 * Whether the controller API is initialized or not. If false, all calls will fail.
	 */
	public var active(default, null):Bool = false;

	/**
	 * Reconfigure the controller to use the specified action set (ie 'Menu', 'Walk' or 'Drive')
	 * This is cheap, and can be safely called repeatedly. It's often easier to repeatedly call it in
	 * your state loops, instead of trying to place it in all of your state transitions.
	 *
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	actionSet	handle received from getActionSetHandle()
	 * @return	1 = success, 0 = failure
	 */
	public function activateActionSet(controller:Int, actionSet:Int):Void {
		if (!active) return;
		_ActivateActionSet(controller, actionSet);
	}

	/**
	 * Get the handle of the current action set
	 *
	 * @param	controller	handle received from getConnectedControllers()
	 * @return	handle of the current action set
	 */
	public function getCurrentActionSet(controller:Int):Int {
		if (!active) return -1;
		return _GetCurrentActionSet(controller);
	}

	/**
	 * Lookup the handle for an Action Set. Best to do this once on startup, and store the handles for all future API calls.
	 *
	 * @param	name identifier for the action set specified in your vdf file (ie, 'Menu', 'Walk' or 'Drive')
	 * @return	action set handle
	 */
	public function getActionSetHandle(name:String):Int {
		if (!active) return -1;
		return _GetActionSetHandle(@:privateAccess name.toUtf8());
	}

	/**
	 * Returns the current state of the supplied analog game action
	 *
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	action	handle received from getActionSetHandle()
	 * @param	data	existing ControllerAnalogActionData structure you want to fill (optional)
	 * @return	data structure containing analog x,y values & other data
	 */
	public function getAnalogActionData(controller:Int, action:Int, ?data:ControllerAnalogActionData):ControllerAnalogActionData {
		if (data == null) {
			data = new ControllerAnalogActionData();
		}

		if (!active) return data;

		_GetAnalogActionData(controller, action, data);

		return data;
	}

	/**
	 * Lookup the handle for an analog (continuos range) action. Best to do this once on startup, and store the handles for all future API calls.
	 *
	 * @param	name	identifier for the action specified in your vdf file (ie, 'Jump', 'Fire', or 'Move')
	 * @return	action analog action handle
	 */
	public function getAnalogActionHandle(name:String):Int {
		if (!active) return -1;
		return _GetAnalogActionHandle(@:privateAccess name.toUtf8());
	}

	/**
	 * Get the origin(s) for an analog action with an action set. Use this to display the appropriate on-screen prompt for the action.
	 * NOTE: Users can change their action origins at any time, and Valve says this is a cheap call and recommends you poll it continuosly
	 * to update your on-screen glyph visuals, rather than calling it rarely and caching the values.
	 *
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	actionSet	handle received from getActionSetHandle()
	 * @param	action	handle received from getAnalogActionHandle()
	 * @param	originsOut	existing array of EControllerActionOrigins you want to fill (optional)
	 * @return the number of origins supplied in originsOut.
	 */

	public function getAnalogActionOrigins(controller:Int, actionSet:Int, action:Int, ?originsOut:Array<EControllerActionOrigin>):Int {
		if (!active) return -1;
		var a:hl.NativeArray<Int> = _GetAnalogActionOrigins(controller, actionSet, action);
		if( a == null ) return 0;

		if (originsOut != null) {
			for (i in 0...a.length) {
				originsOut[i] = cast a[i];
			}
		}

		return a.length;
	}

	static var connectedControllers : hl.NativeArray<Int>;

	/**
	 * Enumerate currently connected controllers
	 *
	 * NOTE: the native steam controller handles are uint64's and too large to easily pass to Haxe,
	 * so the "true" values are left on the C++ side and haxe only deals with 0-based integer indeces
	 * that map back to the "true" values on the C++ side
	 *
	 * @return controller handles
	 */
	public function getConnectedControllers():Array<Int> {
		if (!active) return [];
		connectedControllers = _GetConnectedControllers(connectedControllers);
		return [for(idx in connectedControllers) if( idx >= 0 ) idx];
	}

	/**
	 * Returns the current state of the supplied digital game action
	 *
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	action	handle received from getDigitalActionHandle()
	 * @return
	 */
	public function getDigitalActionData(controller:Int, action:Int):ControllerDigitalActionData {
		if (!active) return new ControllerDigitalActionData(0);
		return new ControllerDigitalActionData(_GetDigitalActionData(controller, action));
	}

	/**
	 * Lookup the handle for a digital (true/false) action. Best to do this once on startup, and store the handles for all future API calls.
	 *
	 * @param	name	identifier for the action specified in your vdf file (ie, 'Jump', 'Fire', or 'Move')
	 * @return	digital action handle
	 */
	public function getDigitalActionHandle(name:String):Int {
		if (!active) return -1;
		return _GetDigitalActionHandle(@:privateAccess name.toUtf8());
	}

	/**
	 * Get the origin(s) for a digital action with an action set. Use this to display the appropriate on-screen prompt for the action.
	 *
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	actionSet	handle received from getActionSetHandle()
	 * @param	action	handle received from getDigitalActionHandle()
	 * @param	originsOut	existing array of EControllerActionOrigins you want to fill (optional)
	 * @return the number of origins supplied in originsOut.
	 */

	public function getDigitalActionOrigins(controller:Int, actionSet:Int, action:Int, ?originsOut:Array<EControllerActionOrigin>):Int {
		if (!active) return 0;
		var a:hl.NativeArray<Int> = _GetDigitalActionOrigins(controller, actionSet, action);
		if( a == null ) return 0;

		//rest of the values are the actual origins
		if (originsOut != null) {
			for (i in 0...a.length) {
				originsOut[i] = cast a[i];
			}
		}

		return a.length;
	}

	/**
	 * Get a local path to art for on-screen glyph for a particular origin
	 * @param	origin
	 * @return
	 */
	public function getGlyphForActionOrigin(origin:EControllerActionOrigin):String {
		var g = _GetGlyphForActionOrigin(origin);
		return g == null ? null : @:privateAccess String.fromUTF8(g);
	}

	/**
	 * Returns a localized string (from Steam's language setting) for the specified origin
	 * @param	origin
	 * @return
	 */
	public function getStringForActionOrigin(origin:EControllerActionOrigin):String {
		var s = _GetStringForActionOrigin(origin);
		return s == null ? null : @:privateAccess String.fromUTF8(s);
	}


	/**
	 * Activates the Steam overlay and shows the input configuration (binding) screen
	 * @return false if overlay is disabled / unavailable, or if the Steam client is not in Big Picture mode
	 */
	public function showBindingPanel(controller:Int):Bool {
		var result:Bool = _ShowBindingPanel(controller);
		return result;
	}


	/**
	 * Activates the Big Picture text input dialog which only supports gamepad input
	 * @param	inputMode	NORMAL or PASSWORD
	 * @param	lineMode	SINGLE_LINE or MULTIPLE_LINES
	 * @param	description	User-facing description of what's being entered, e.g. "Please enter your name"
	 * @param	charMax	Maximum number of characters
	 * @param	existingText	Text to pre-fill the dialog with, if any
	 * @return
	 */
	public function showGamepadTextInput(inputMode:EGamepadTextInputMode, lineMode:EGamepadTextInputLineMode, description:String, charMax:Int = 0xFFFFFF, existingText:String = ""):Bool {
		return _ShowGamepadTextInput(inputMode, lineMode, @:privateAccess description.toUtf8(), charMax, @:privateAccess existingText.toUtf8());
	}

	/**
	 * Returns the text that the player has entered using showGamepadTextInput()
	 * @return
	 */
	public function getEnteredGamepadTextInput():String {
		return @:privateAccess String.fromUTF8(_GetEnteredGamepadTextInput());
	}


	/**
	 * Must be called when ending use of this API
	 */
	public function shutdown() {
		_ShutdownControllers();
		active = false;
	}

	/**
	 * Trigger a haptic pulse in a slightly friendlier way
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	targetPad	which pad you want to pulse
	 * @param	durationMilliSec	duration of the pulse, in milliseconds (1/1000 sec)
	 * @param	strength	value between 0 and 1, general intensity of the pulsing
	 */
	public function hapticPulseRumble(controller:Int, targetPad:ESteamControllerPad, durationMilliSec:Int, strength:Float) {

		if (strength <= 0) return;
		if (strength >  1) strength = 1;

		var durationMicroSec = durationMilliSec * 1000;
		var repeat = 1;

		if (durationMicroSec > MAX_SINGLE_PULSE_TIME)
		{
			repeat = Math.ceil(durationMicroSec / MAX_SINGLE_PULSE_TIME);
			durationMicroSec = MAX_SINGLE_PULSE_TIME;
		}

		var onTime  = Std.int(durationMicroSec * strength);
		var offTime = Std.int(durationMicroSec * (1 - strength));

		if (offTime <= 0) offTime = 1;

		if (repeat > 1)
		{
			triggerRepeatedHapticPulse(controller, targetPad, onTime, offTime, repeat, 0);
		}
		else
		{
			triggerHapticPulse(controller, targetPad, onTime);
		}
	}

	/**
	 * Trigger a single haptic pulse (low-level)
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	targetPad	which pad you want to pulse
	 * @param	durationMicroSec	duration of the pulse, in microseconds (1/1000 ms)
	 */
	public function triggerHapticPulse(controller:Int, targetPad:ESteamControllerPad, durationMicroSec:Int) {
		     if (durationMicroSec < 0) durationMicroSec = 0;
		else if (durationMicroSec > MAX_SINGLE_PULSE_TIME) durationMicroSec = MAX_SINGLE_PULSE_TIME;

		switch(targetPad)
		{
			case LEFT, RIGHT:
				_TriggerHapticPulse(controller, cast targetPad, durationMicroSec);
			case BOTH:
				triggerHapticPulse(controller,  LEFT, durationMicroSec);
				triggerHapticPulse(controller, RIGHT, durationMicroSec);
		}
	}

	/**
	 * Trigger a repeated haptic pulse (low-level)
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	targetPad	which pad you want to pulse
	 * @param	durationMicroSec	duration of the pulse, in microseconds (1/1,000 ms)
	 * @param	offMicroSec	offset between pulses, in microseconds (1/1,000 ms)
	 * @param	repeat	number of pulses
	 * @param	flags	special behavior flags
	 */
	public function triggerRepeatedHapticPulse(controller:Int, targetPad:ESteamControllerPad, durationMicroSec:Int, offMicroSec:Int, repeat:Int, flags:Int) {
		     if (durationMicroSec < 0) durationMicroSec = 0;
		else if (durationMicroSec > MAX_SINGLE_PULSE_TIME) durationMicroSec = MAX_SINGLE_PULSE_TIME;

		switch(targetPad)
		{
			case LEFT, RIGHT:
				_TriggerRepeatedHapticPulse(controller, cast targetPad, durationMicroSec, offMicroSec, repeat, flags);
			case BOTH:
				triggerRepeatedHapticPulse(controller,  LEFT, durationMicroSec, offMicroSec, repeat, flags);
				triggerRepeatedHapticPulse(controller, RIGHT, durationMicroSec, offMicroSec, repeat, flags);
		}
	}

	/**
	 * Trigger a vibration event on supported controllers
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	leftSpeed	how fast the left motor should vibrate (0-65,535)
	 * @param	rightSpeed	how fast the right motor should vibrate (0-65,535)
	 */
	public function triggerVibration(controller:Int, leftSpeed:Int, rightSpeed:Int) {

		if (leftSpeed < 0) leftSpeed = 0;
		if (leftSpeed > 65535) leftSpeed = 65535;
		if (rightSpeed < 0) rightSpeed = 0;
		if (rightSpeed > 65535) rightSpeed = 65535;
		_TriggerVibration(controller, leftSpeed, rightSpeed);

	}

	/**
	 * Set the controller LED color on supported controllers.
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	rgb	an RGB color in 0xRRGGBB format
	 * @param	flags	bit-masked flags combined from values defined in ESteamControllerLEDFlags
	 */
	public function setLEDColor(controller:Int, rgb:Int, flags:Int=ESteamControllerLEDFlags.SET_COLOR) {

		var r = (rgb >> 16) & 0xFF;
		var g = (rgb >> 8) & 0xFF;
		var b = rgb & 0xFF;
		_SetLEDColor(controller, r, g, b, flags);

	}

	/**
		Restores the LED color set by the user.
	**/
	public function resetLEDColor(controller:Int) {
		_SetLEDColor(controller, 0, 0, 0, ESteamControllerLEDFlags.RESTORE_USER_DEFAULT);
	}


	/**
		Returns the XInput gamepad index of the controller, or `-1` if it is not emulating a gamepad.
	**/
	public function getGamepadIndexForController(controller:Int):Int {
		//TODO
		return -1;
	}


	/**
		Returns the controller emulating the XInput gamepad index.
	**/
	public function getControllerForGamepadIndex(index:Int):Int {
		//TODO
		return -1;
	}

	/**
	 * Returns the current state of the supplied analog game action
	 *
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	data	existing ControllerMotionData structure you want to fill (optional)
	 * @return	data structure containing motion data values
	 */
	public function getMotionData(controller:Int, ?data:ControllerMotionData):ControllerMotionData{
		if (data == null) {
			data = new ControllerMotionData();
		}

		if (!active) return data;

		_GetMotionData(controller, data);


		return data;
	}

	/**
	 * Attempt to display origins of given action in the controller HUD, for the currently active action set
	 * Returns false is overlay is disabled / unavailable, or the user is not in Big Picture mode
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	digitalActionHandle	handle received from getDigitalActionHandle()
	 * @param	scale	scale multiplier to apply to the on-screen display (1.0 is 1:1 size)
	 * @param	xPosition	position of the on-screen display (0.5 is the center)
	 * @param	yPosition	position of the on-screen display (0.5 is the center)
	 */
	public function showDigitalActionOrigins(controller:Int, digitalActionHandle:Int, scale:Float, xPosition:Float, yPosition:Float) {

		_ShowDigitalActionOrigins(controller, digitalActionHandle, scale, xPosition, yPosition);

	}

	/**
	 * Attempt to display origins of given action in the controller HUD, for the currently active action set
	 * Returns false is overlay is disabled / unavailable, or the user is not in Big Picture mode
	 * @param	controller	handle received from getConnectedControllers()
	 * @param	analogActionHandle	handle received from getDigitalActionHandle()
	 * @param	scale	scale multiplier to apply to the on-screen display (1.0 is 1:1 size)
	 * @param	xPosition	position of the on-screen display (0.5 is the center)
	 * @param	yPosition	position of the on-screen display (0.5 is the center)
	 */
	public function showAnalogActionOrigins(controller:Int, analogActionHandle:Int, scale:Float, xPosition:Float, yPosition:Float) {

		_ShowAnalogActionOrigins(controller, analogActionHandle, scale, xPosition, yPosition);

	}

	/*************PRIVATE***************/

	private var customTrace:String->Void;

	@:hlNative("steam","init_controllers") private static function _InitControllers() : Bool { return false; }
	@:hlNative("steam","shutdown_controllers") private static function _ShutdownControllers() : Bool { return false; }
	@:hlNative("steam","get_connected_controllers") private static function _GetConnectedControllers( arr : hl.NativeArray<Int> ) : hl.NativeArray<Int> { return null; }
	@:hlNative("steam","get_digital_action_origins") private static function _GetDigitalActionOrigins( controller : Int, action : Int, digitalAction : Int ) : hl.NativeArray<Int> { return null; }
	@:hlNative("steam","get_entered_gamepad_text_input") private static function _GetEnteredGamepadTextInput() : hl.Bytes { return null; }
	@:hlNative("steam","get_analog_action_origins") private static function _GetAnalogActionOrigins( controller : Int, action : Int, analogAction : Int ) : hl.NativeArray<Int> { return null; }
	@:hlNative("steam","show_binding_panel") private static function _ShowBindingPanel( controller : Int ) : Bool { return false; }
	@:hlNative("steam","get_string_for_action_origin") private static function _GetStringForActionOrigin( origin : Int ) : hl.Bytes { return null; }
	@:hlNative("steam","get_glyph_for_action_origin") private static function _GetGlyphForActionOrigin( origin : Int ) : hl.Bytes { return null; }
	@:hlNative("steam","get_controller_max_count") private static function _GetControllerMaxCount() : Int { return 0; }
	@:hlNative("steam","get_controller_max_analog_actions") private static function _GetControllerMaxAnalogActions() : Int { return 0; }
	@:hlNative("steam","get_controller_max_digital_actions") private static function _GetControllerMaxDigitalActions() : Int { return 0; }
	@:hlNative("steam","get_controller_max_origins") private static function _GetControllerMaxOrigins() : Int { return 0; }
	@:hlNative("steam","get_controller_max_analog_action_data") private static function _GetControllerMaxAnalogActionData() : Float { return 0.; }
	@:hlNative("steam","get_controller_min_analog_action_data") private static function _GetControllerMinAnalogActionData() : Float { return 0.; }
	@:hlNative("steam","activate_action_set") private static function _ActivateActionSet( controller : Int, action : Int ): Void{};
	@:hlNative("steam","get_current_action_set") private static function _GetCurrentActionSet( controller : Int ) : Int { return 0; }
	@:hlNative("steam","get_action_set_handle") private static function _GetActionSetHandle( name : hl.Bytes ) : Int { return 0; }
	@:hlNative("steam","get_analog_action_data") private static function _GetAnalogActionData( controller : Int, action : Int, data : ControllerAnalogActionData ): Void{};
	@:hlNative("steam","get_analog_action_handle") private static function _GetAnalogActionHandle( name : hl.Bytes ) : Int { return 0; }
	@:hlNative("steam","get_digital_action_data") private static function _GetDigitalActionData( controller : Int, action : Int ) : Int { return 0; }
	@:hlNative("steam","get_digital_action_handle") private static function _GetDigitalActionHandle( name : hl.Bytes ) : Int { return 0; }
	@:hlNative("steam","show_gamepad_text_input") private static function _ShowGamepadTextInput( inputMode : Int, lineMode : Int, description : hl.Bytes, charMax : Int, existingText : hl.Bytes ) : Bool { return false; }
	@:hlNative("steam","trigger_haptic_pulse") private static function _TriggerHapticPulse( controller : Int, targetPad : Int, duration : Int ): Void{};
	@:hlNative("steam","trigger_repeated_haptic_pulse") private static function _TriggerRepeatedHapticPulse( controller : Int, targetPad : Int, duration : Int, off : Int, repeat : Int, flags : Int ): Void{};
	@:hlNative("steam","trigger_vibration") private static function _TriggerVibration( controller : Int, leftSpeed : Int, rightSpeed : Int ): Void{};
	@:hlNative("steam","set_led_color") private static function _SetLEDColor( controller : Int, r : Int, g : Int, b : Int, flags : Int ): Void{};
	@:hlNative("steam","get_motion_data") private static function _GetMotionData( controller : Int, data : ControllerMotionData ): Void{};
	@:hlNative("steam","show_digital_action_origins") private static function _ShowDigitalActionOrigins( controller : Int, digitalAction : Int, scale : Float, xPos : Float, yPos : Float ) : Bool { return false; }
	@:hlNative("steam","show_analog_action_origins") private static function _ShowAnalogActionOrigins( controller : Int, analogAction : Int, scale : Float, xPos : Float, yPos : Float ) : Bool { return false; }


	private function new(CustomTrace:String->Void)
	{
		customTrace = CustomTrace;
		init();
	}

	private function init()
	{
		if (active) return;

		// if we get this far, the dlls loaded ok and we need Steam controllers to init.
		// otherwise, we're trying to run the Steam version without the Steam client
		active = _InitControllers();
	}

	private var max_controllers:Int = -1;
	private function get_MAX_CONTROLLERS():Int
	{
		if(max_controllers == -1)
			max_controllers = _GetControllerMaxCount();
		return max_controllers;
	}

	private var max_analog_actions = -1;
	private function get_MAX_ANALOG_ACTIONS():Int
	{
		if(max_analog_actions == -1)
			max_analog_actions = _GetControllerMaxAnalogActions();
		return max_analog_actions;
	}

	private var max_digital_actions = -1;
	private function get_MAX_DIGITAL_ACTIONS():Int
	{
		if (max_digital_actions == -1)
			max_digital_actions = _GetControllerMaxDigitalActions();
		return max_digital_actions;
	}

	private var max_origins = -1;
	private function get_MAX_ORIGINS():Int
	{
		if(max_origins == -1)
			max_origins = _GetControllerMaxOrigins();
		return max_origins;
	}

	private var max_analog_value = Math.NaN;
	private function get_MAX_ANALOG_VALUE():Float
	{
		if(Math.isNaN(max_analog_value))
			max_analog_value = _GetControllerMaxAnalogActionData();
		return max_analog_value;
	}

	private var min_analog_value = Math.NaN;
	private function get_MIN_ANALOG_VALUE():Float
	{
		if(Math.isNaN(min_analog_value))
			min_analog_value = _GetControllerMinAnalogActionData();
		return min_analog_value;
	}
}

/**
	The state of a digital action.
**/
abstract ControllerDigitalActionData(Int) from Int to Int{

	public function new(i:Int) {
		this = i;
	}

	/**
		Tells if the action is pressed.
	**/
	public var bState(get, never):Bool;
	private function get_bState():Bool { return this & 0x1 == 0x1; }

	/**
		Tells if the action is available in the current action set.
	**/
	public var bActive(get, never):Bool;
	private function get_bActive():Bool { return this & 0x10 == 0x10; }
}

/**
	The state of an analog action.
**/
class ControllerAnalogActionData
{
	/**
		Tells if the action is available in the current action set.
	**/
	public var bActive:Bool = false;
	/**
		The mode of the source of the action.
	**/
	public var eMode:EControllerSourceMode = NONE;
	/**
		The X value.
	**/
	public var x:Float = 0.0;
	/**
		The Y value.
	**/
	public var y:Float = 0.0;

	/**
		Creates empty data.
	**/
	public function new(){}
}

/**
	The motion data of a controller.
**/
class ControllerMotionData
{
	/**
		The X of the sensor-fused absolute rotation quaternion (drifts in heading).
	**/
	public var rotQuatX:Float = 0.0;
	/**
		The Y of the absolute rotation quaternion.
	**/
	public var rotQuatY:Float = 0.0;
	/**
		The Z of the absolute rotation quaternion.
	**/
	public var rotQuatZ:Float = 0.0;
	/**
		The W of the absolute rotation quaternion.
	**/
	public var rotQuatW:Float = 0.0;

	/**
		The X positional acceleration.
	**/
	public var posAccelX:Float = 0.0;
	/**
		The Y positional acceleration.
	**/
	public var posAccelY:Float = 0.0;
	/**
		The Z positional acceleration.
	**/
	public var posAccelZ:Float = 0.0;

	/**
		The X angular velocity.
	**/
	public var rotVelX:Float = 0.0;
	/**
		The Y angular velocity.
	**/
	public var rotVelY:Float = 0.0;
	/**
		The Z angular velocity.
	**/
	public var rotVelZ:Float = 0.0;

	/**
		Creates empty data.
	**/
	public function new(){}

	/**
		Returns a description of the data.
	**/
	public function toString():String{
		return "ControllerMotionData{rotQuad:(" + rotQuatX + "," + rotQuatY + "," + rotQuatZ + "," + rotQuatW + "), " +
									"posAccel:(" + posAccelX + "," + posAccelY + "," + posAccelZ + "), " +
									"rotVel:(" + rotVelX + "," + rotVelY + "," + rotVelZ + ")}";
	}
}

/**
	The flags of `Controller.setLEDColor`.
**/
class ESteamControllerLEDFlags {

	/**
		Sets the color.
	**/
	public static inline var SET_COLOR = 0x01;
	/**
		Restores the color set by the user.
	**/
	public static inline var RESTORE_USER_DEFAULT = 0x10;

}

/**
	A physical input of a controller bound to an action (Steamworks `EControllerActionOrigin`). Converts from a number or a name (`"XBOXONE_A"`), and to its name.
**/
enum abstract EControllerActionOrigin(Int) to Int {

	/**
		The origins by name.
	**/
	public static var fromStringMap(default, null):Map<String, EControllerActionOrigin>
		= MacroHelper.buildMap("steam.EControllerActionOrigin");

	/**
		The names by origin.
	**/
	public static var toStringMap(default, null):Map<EControllerActionOrigin, String>
		= MacroHelper.buildMap("steam.EControllerActionOrigin", true);

	/**
		No origin.
	**/
	public var NONE = 0;

	//Valve Steam Controller:
	/**
		Steam Controller: A button.
	**/
	public var A = 1;
	/**
		Steam Controller: B button.
	**/
	public var B = 2;
	/**
		Steam Controller: X button.
	**/
	public var X = 3;
	/**
		Steam Controller: Y button.
	**/
	public var Y = 4;
	/**
		Steam Controller: left bumper.
	**/
	public var LEFTBUMPER= 5;
	/**
		Steam Controller: right bumper.
	**/
	public var RIGHTBUMPER= 6;
	/**
		Steam Controller: left grip.
	**/
	public var LEFTGRIP = 7;
	/**
		Steam Controller: right grip.
	**/
	public var RIGHTGRIP = 8;
	/**
		Steam Controller: start button.
	**/
	public var START = 9;
	/**
		Steam Controller: back button.
	**/
	public var BACK = 10;
	/**
		Steam Controller: left trackpad, touch.
	**/
	public var LEFTPAD_TOUCH = 11;
	/**
		Steam Controller: left trackpad, swipe.
	**/
	public var LEFTPAD_SWIPE = 12;
	/**
		Steam Controller: left trackpad, click.
	**/
	public var LEFTPAD_CLICK = 13;
	/**
		Steam Controller: left trackpad, up.
	**/
	public var LEFTPAD_DPADNORTH = 14;
	/**
		Steam Controller: left trackpad, down.
	**/
	public var LEFTPAD_DPADSOUTH = 15;
	/**
		Steam Controller: left trackpad, left.
	**/
	public var LEFTPAD_DPADWEST = 16;
	/**
		Steam Controller: left trackpad, right.
	**/
	public var LEFTPAD_DPADEAST = 17;
	/**
		Steam Controller: right trackpad, touch.
	**/
	public var RIGHTPAD_TOUCH = 18;
	/**
		Steam Controller: right trackpad, swipe.
	**/
	public var RIGHTPAD_SWIPE = 19;
	/**
		Steam Controller: right trackpad, click.
	**/
	public var RIGHTPAD_CLICK = 20;
	/**
		Steam Controller: right trackpad, up.
	**/
	public var RIGHTPAD_DPADNORTH = 21;
	/**
		Steam Controller: right trackpad, down.
	**/
	public var RIGHTPAD_DPADSOUTH = 22;
	/**
		Steam Controller: right trackpad, left.
	**/
	public var RIGHTPAD_DPADWEST = 23;
	/**
		Steam Controller: right trackpad, right.
	**/
	public var RIGHTPAD_DPADEAST = 24;
	/**
		Steam Controller: left trigger, pull.
	**/
	public var LEFTTRIGGER_PULL = 25;
	/**
		Steam Controller: left trigger, click.
	**/
	public var LEFTTRIGGER_CLICK = 26;
	/**
		Steam Controller: right trigger, pull.
	**/
	public var RIGHTTRIGGER_PULL = 27;
	/**
		Steam Controller: right trigger, click.
	**/
	public var RIGHTTRIGGER_CLICK = 28;
	/**
		Steam Controller: left stick, move.
	**/
	public var LEFTSTICK_MOVE = 29;
	/**
		Steam Controller: left stick, click.
	**/
	public var LEFTSTICK_CLICK = 30;
	/**
		Steam Controller: left stick, up.
	**/
	public var LEFTSTICK_DPADNORTH = 31;
	/**
		Steam Controller: left stick, down.
	**/
	public var LEFTSTICK_DPADSOUTH = 32;
	/**
		Steam Controller: left stick, left.
	**/
	public var LEFTSTICK_DPADWEST = 33;
	/**
		Steam Controller: left stick, right.
	**/
	public var LEFTSTICK_DPADEAST = 34;
	/**
		Steam Controller: gyro, move.
	**/
	public var GYRO_MOVE = 35;
	/**
		Steam Controller: gyro, pitch.
	**/
	public var GYRO_PITCH = 36;
	/**
		Steam Controller: gyro, yaw.
	**/
	public var GYRO_YAW = 37;
	/**
		Steam Controller: gyro, roll.
	**/
	public var GYRO_ROLL = 38;

	//Sony PlayStation DualShock 4:
	/**
		PS4 controller: cross button.
	**/
	public var PS4_X = 39;
	/**
		PS4 controller: circle button.
	**/
	public var PS4_CIRCLE = 40;
	/**
		PS4 controller: triangle button.
	**/
	public var PS4_TRIANGLE = 41;
	/**
		PS4 controller: square button.
	**/
	public var PS4_SQUARE = 42;
	/**
		PS4 controller: left bumper.
	**/
	public var PS4_LEFTBUMPER = 43;
	/**
		PS4 controller: right bumper.
	**/
	public var PS4_RIGHTBUMPER = 44;
	/**
		PS4 controller: Options button.
	**/
	public var PS4_OPTIONS = 45;
	/**
		PS4 controller: Share button.
	**/
	public var PS4_SHARE = 46;
	/**
		PS4 controller: left trackpad, touch.
	**/
	public var PS4_LEFTPAD_TOUCH = 47;
	/**
		PS4 controller: left trackpad, swipe.
	**/
	public var PS4_LEFTPAD_SWIPE = 48;
	/**
		PS4 controller: left trackpad, click.
	**/
	public var PS4_LEFTPAD_CLICK = 49;
	/**
		PS4 controller: left trackpad, up.
	**/
	public var PS4_LEFTPAD_DPADNORTH = 50;
	/**
		PS4 controller: left trackpad, down.
	**/
	public var PS4_LEFTPAD_DPADSOUTH = 51;
	/**
		PS4 controller: left trackpad, left.
	**/
	public var PS4_LEFTPAD_DPADWEST = 52;
	/**
		PS4 controller: left trackpad, right.
	**/
	public var PS4_LEFTPAD_DPADEAST = 53;
	/**
		PS4 controller: right trackpad, touch.
	**/
	public var PS4_RIGHTPAD_TOUCH = 54;
	/**
		PS4 controller: right trackpad, swipe.
	**/
	public var PS4_RIGHTPAD_SWIPE = 55;
	/**
		PS4 controller: right trackpad, click.
	**/
	public var PS4_RIGHTPAD_CLICK = 56;
	/**
		PS4 controller: right trackpad, up.
	**/
	public var PS4_RIGHTPAD_DPADNORTH = 57;
	/**
		PS4 controller: right trackpad, down.
	**/
	public var PS4_RIGHTPAD_DPADSOUTH = 58;
	/**
		PS4 controller: right trackpad, left.
	**/
	public var PS4_RIGHTPAD_DPADWEST = 59;
	/**
		PS4 controller: right trackpad, right.
	**/
	public var PS4_RIGHTPAD_DPADEAST = 60;
	/**
		PS4 controller: center trackpad, touch.
	**/
	public var PS4_CENTERPAD_TOUCH = 61;
	/**
		PS4 controller: center trackpad, swipe.
	**/
	public var PS4_CENTERPAD_SWIPE = 62;
	/**
		PS4 controller: center trackpad, click.
	**/
	public var PS4_CENTERPAD_CLICK = 63;
	/**
		PS4 controller: center trackpad, up.
	**/
	public var PS4_CENTERPAD_DPADNORTH = 64;
	/**
		PS4 controller: center trackpad, down.
	**/
	public var PS4_CENTERPAD_DPADSOUTH = 65;
	/**
		PS4 controller: center trackpad, left.
	**/
	public var PS4_CENTERPAD_DPADWEST = 66;
	/**
		PS4 controller: center trackpad, right.
	**/
	public var PS4_CENTERPAD_DPADEAST = 67;
	/**
		PS4 controller: left trigger, pull.
	**/
	public var PS4_LEFTTRIGGER_PULL = 68;
	/**
		PS4 controller: left trigger, click.
	**/
	public var PS4_LEFTTRIGGER_CLICK = 69;
	/**
		PS4 controller: right trigger, pull.
	**/
	public var PS4_RIGHTTRIGGER_PULL = 70;
	/**
		PS4 controller: right trigger, click.
	**/
	public var PS4_RIGHTTRIGGER_CLICK = 71;
	/**
		PS4 controller: left stick, move.
	**/
	public var PS4_LEFTSTICK_MOVE = 72;
	/**
		PS4 controller: left stick, click.
	**/
	public var PS4_LEFTSTICK_CLICK = 73;
	/**
		PS4 controller: left stick, up.
	**/
	public var PS4_LEFTSTICK_DPADNORTH = 74;
	/**
		PS4 controller: left stick, down.
	**/
	public var PS4_LEFTSTICK_DPADSOUTH = 75;
	/**
		PS4 controller: left stick, left.
	**/
	public var PS4_LEFTSTICK_DPADWEST = 76;
	/**
		PS4 controller: left stick, right.
	**/
	public var PS4_LEFTSTICK_DPADEAST = 77;
	/**
		PS4 controller: right stick, move.
	**/
	public var PS4_RIGHTSTICK_MOVE = 78;
	/**
		PS4 controller: right stick, click.
	**/
	public var PS4_RIGHTSTICK_CLICK = 79;
	/**
		PS4 controller: right stick, up.
	**/
	public var PS4_RIGHTSTICK_DPADNORTH = 80;
	/**
		PS4 controller: right stick, down.
	**/
	public var PS4_RIGHTSTICK_DPADSOUTH = 81;
	/**
		PS4 controller: right stick, left.
	**/
	public var PS4_RIGHTSTICK_DPADWEST = 82;
	/**
		PS4 controller: right stick, right.
	**/
	public var PS4_RIGHTSTICK_DPADEAST = 83;
	/**
		PS4 controller: D-pad, up.
	**/
	public var PS4_DPAD_NORTH = 84;
	/**
		PS4 controller: D-pad, down.
	**/
	public var PS4_DPAD_SOUTH = 85;
	/**
		PS4 controller: D-pad, left.
	**/
	public var PS4_DPAD_WEST = 86;
	/**
		PS4 controller: D-pad, right.
	**/
	public var PS4_DPAD_EAST = 87;
	/**
		PS4 controller: gyro, move.
	**/
	public var PS4_GYRO_MOVE = 88;
	/**
		PS4 controller: gyro, pitch.
	**/
	public var PS4_GYRO_PITCH = 89;
	/**
		PS4 controller: gyro, yaw.
	**/
	public var PS4_GYRO_YAW = 90;
	/**
		PS4 controller: gyro, roll.
	**/
	public var PS4_GYRO_ROLL = 91;

	//Microsoft XBox One:
	/**
		Xbox One controller: A button.
	**/
	public var XBOXONE_A = 92;
	/**
		Xbox One controller: B button.
	**/
	public var XBOXONE_B = 93;
	/**
		Xbox One controller: X button.
	**/
	public var XBOXONE_X = 94;
	/**
		Xbox One controller: Y button.
	**/
	public var XBOXONE_Y = 95;
	/**
		Xbox One controller: left bumper.
	**/
	public var XBOXONE_LEFTBUMPER = 96;
	/**
		Xbox One controller: right bumper.
	**/
	public var XBOXONE_RIGHTBUMPER = 97;
	/**
		Xbox One controller: Menu button.
	**/
	public var XBOXONE_MENU = 98;
	/**
		Xbox One controller: View button.
	**/
	public var XBOXONE_VIEW = 99;
	/**
		Xbox One controller: left trigger, pull.
	**/
	public var XBOXONE_LEFTTRIGGER_PULL = 100;
	/**
		Xbox One controller: left trigger, click.
	**/
	public var XBOXONE_LEFTTRIGGER_CLICK = 101;
	/**
		Xbox One controller: right trigger, pull.
	**/
	public var XBOXONE_RIGHTTRIGGER_PULL = 102;
	/**
		Xbox One controller: right trigger, click.
	**/
	public var XBOXONE_RIGHTTRIGGER_CLICK = 103;
	/**
		Xbox One controller: left stick, move.
	**/
	public var XBOXONE_LEFTSTICK_MOVE = 104;
	/**
		Xbox One controller: left stick, click.
	**/
	public var XBOXONE_LEFTSTICK_CLICK = 105;
	/**
		Xbox One controller: left stick, up.
	**/
	public var XBOXONE_LEFTSTICK_DPADNORTH = 106;
	/**
		Xbox One controller: left stick, down.
	**/
	public var XBOXONE_LEFTSTICK_DPADSOUTH = 107;
	/**
		Xbox One controller: left stick, left.
	**/
	public var XBOXONE_LEFTSTICK_DPADWEST = 108;
	/**
		Xbox One controller: left stick, right.
	**/
	public var XBOXONE_LEFTSTICK_DPADEAST = 109;
	/**
		Xbox One controller: right stick, move.
	**/
	public var XBOXONE_RIGHTSTICK_MOVE = 110;
	/**
		Xbox One controller: right stick, click.
	**/
	public var XBOXONE_RIGHTSTICK_CLICK = 111;
	/**
		Xbox One controller: right stick, up.
	**/
	public var XBOXONE_RIGHTSTICK_DPADNORTH = 112;
	/**
		Xbox One controller: right stick, down.
	**/
	public var XBOXONE_RIGHTSTICK_DPADSOUTH = 113;
	/**
		Xbox One controller: right stick, left.
	**/
	public var XBOXONE_RIGHTSTICK_DPADWEST = 114;
	/**
		Xbox One controller: right stick, right.
	**/
	public var XBOXONE_RIGHTSTICK_DPADEAST = 115;
	/**
		Xbox One controller: D-pad, up.
	**/
	public var XBOXONE_DPAD_NORTH = 116;
	/**
		Xbox One controller: D-pad, down.
	**/
	public var XBOXONE_DPAD_SOUTH = 117;
	/**
		Xbox One controller: D-pad, left.
	**/
	public var XBOXONE_DPAD_WEST = 118;
	/**
		Xbox One controller: D-pad, right.
	**/
	public var XBOXONE_DPAD_EAST = 119;

	//Microsoft XBox 360:
	/**
		Xbox 360 controller: A button.
	**/
	public var XBOX360_A = 120;
	/**
		Xbox 360 controller: B button.
	**/
	public var XBOX360_B = 121;
	/**
		Xbox 360 controller: X button.
	**/
	public var XBOX360_X = 122;
	/**
		Xbox 360 controller: Y button.
	**/
	public var XBOX360_Y = 123;
	/**
		Xbox 360 controller: left bumper.
	**/
	public var XBOX360_LEFTBUMPER = 124;
	/**
		Xbox 360 controller: right bumper.
	**/
	public var XBOX360_RIGHTBUMPER = 125;
	/**
		Xbox 360 controller: start button.
	**/
	public var XBOX360_START = 126;
	/**
		Xbox 360 controller: back button.
	**/
	public var XBOX360_BACK = 127;
	/**
		Xbox 360 controller: left trigger, pull.
	**/
	public var XBOX360_LEFTTRIGGER_PULL = 128;
	/**
		Xbox 360 controller: left trigger, click.
	**/
	public var XBOX360_LEFTTRIGGER_CLICK = 129;
	/**
		Xbox 360 controller: right trigger, pull.
	**/
	public var XBOX360_RIGHTTRIGGER_PULL = 130;
	/**
		Xbox 360 controller: right trigger, click.
	**/
	public var XBOX360_RIGHTTRIGGER_CLICK = 131;
	/**
		Xbox 360 controller: left stick, move.
	**/
	public var XBOX360_LEFTSTICK_MOVE = 132;
	/**
		Xbox 360 controller: left stick, click.
	**/
	public var XBOX360_LEFTSTICK_CLICK = 133;
	/**
		Xbox 360 controller: left stick, up.
	**/
	public var XBOX360_LEFTSTICK_DPADNORTH = 134;
	/**
		Xbox 360 controller: left stick, down.
	**/
	public var XBOX360_LEFTSTICK_DPADSOUTH = 135;
	/**
		Xbox 360 controller: left stick, left.
	**/
	public var XBOX360_LEFTSTICK_DPADWEST = 136;
	/**
		Xbox 360 controller: left stick, right.
	**/
	public var XBOX360_LEFTSTICK_DPADEAST = 137;
	/**
		Xbox 360 controller: right stick, move.
	**/
	public var XBOX360_RIGHTSTICK_MOVE = 138;
	/**
		Xbox 360 controller: right stick, click.
	**/
	public var XBOX360_RIGHTSTICK_CLICK = 139;
	/**
		Xbox 360 controller: right stick, up.
	**/
	public var XBOX360_RIGHTSTICK_DPADNORTH = 140;
	/**
		Xbox 360 controller: right stick, down.
	**/
	public var XBOX360_RIGHTSTICK_DPADSOUTH = 141;
	/**
		Xbox 360 controller: right stick, left.
	**/
	public var XBOX360_RIGHTSTICK_DPADWEST = 142;
	/**
		Xbox 360 controller: right stick, right.
	**/
	public var XBOX360_RIGHTSTICK_DPADEAST = 143;
	/**
		Xbox 360 controller: D-pad, up.
	**/
	public var XBOX360_DPAD_NORTH = 144;
	/**
		Xbox 360 controller: D-pad, down.
	**/
	public var XBOX360_DPAD_SOUTH = 145;
	/**
		Xbox 360 controller: D-pad, left.
	**/
	public var XBOX360_DPAD_WEST = 146;
	/**
		Xbox 360 controller: D-pad, right.
	**/
	public var XBOX360_DPAD_EAST = 147;

	/**
		The number of origins.
	**/
	public var COUNT = 148;

	/**
		An unknown origin.
	**/
	public var UNKNOWN = -1;

	@:from private static function fromString (s:String):EControllerActionOrigin {

		var i = Std.parseInt(s);

		if (i == null)
		{
			//if it's not a numeric value, try to interpret it from its name
			s = s.toUpperCase();
			return fromStringMap.exists(s) ? fromStringMap.get(s) : UNKNOWN;
		}

		return cast Std.int(i);

	}

	/**
		Returns the name of the origin, or `unknown`.
	**/
	@:to public inline function toString():String {

		if (toStringMap.exists(cast this))
		{
			return toStringMap.get(cast this);
		}

		return "unknown";
	}

	/**
	 * Returns the string name for this glyph so you can load a corresponding image from your assets.
	 * @param	value the integer value of a controller action origin from the steam API
	 * @return	a unique string identifier for this glyph, OR "unknown" if the glyph is not known (see Controller.getGlyphForActionOrigin())
	 */
	public static function getGlyph(value:EControllerActionOrigin):String {
		return switch(value)
		{
			case NONE:               "none";

			//Valve Steam Controller:
			case A:                  "button_a";
			case B:                  "button_b";
			case X:                  "button_x";
			case Y:                  "button_y";
			case LEFTBUMPER:         "shoulder_l";
			case RIGHTBUMPER:        "shoulder_r";
			case LEFTGRIP:           "grip_l";
			case RIGHTGRIP:          "grip_r";
			case START:              "button_start";
			case BACK:               "button_select";
			case LEFTPAD_TOUCH:      "pad_l_touch";
			case LEFTPAD_SWIPE:      "pad_l_swipe";
			case LEFTPAD_CLICK:      "pad_l_click";
			case LEFTPAD_DPADNORTH:  "pad_l_dpad_n";
			case LEFTPAD_DPADSOUTH:  "pad_l_dpad_s";
			case LEFTPAD_DPADWEST:   "pad_l_dpad_w";
			case LEFTPAD_DPADEAST:   "pad_l_dpad_e";
			case RIGHTPAD_TOUCH:     "pad_r_touch";
			case RIGHTPAD_SWIPE:     "pad_r_swipe";
			case RIGHTPAD_CLICK:     "pad_r_click";
			case RIGHTPAD_DPADNORTH: "pad_r_dpad_n";
			case RIGHTPAD_DPADSOUTH: "pad_r_dpad_s";
			case RIGHTPAD_DPADWEST:  "pad_r_dpad_w";
			case RIGHTPAD_DPADEAST:  "pad_r_dpad_e";
			case LEFTTRIGGER_PULL:   "trigger_l_pull";
			case LEFTTRIGGER_CLICK:  "trigger_l_click";
			case RIGHTTRIGGER_PULL:  "trigger_r_pull";
			case RIGHTTRIGGER_CLICK: "trigger_r_click";
			case LEFTSTICK_MOVE:     "stick_move";
			case LEFTSTICK_CLICK:    "stick_click";
			case LEFTSTICK_DPADNORTH:"stick_dpad_n";
			case LEFTSTICK_DPADSOUTH:"stick_dpad_s";
			case LEFTSTICK_DPADWEST: "stick_dpad_w";
			case LEFTSTICK_DPADEAST: "stick_dpad_e";
			case GYRO_MOVE:          "gyro";
			case GYRO_PITCH:         "gyro_pitch";
			case GYRO_YAW:           "gyro_yaw";
			case GYRO_ROLL:          "gyro_roll";

			//Sony PlayStation DualShock 4:
			case PS4_X:                    "ps4_button_x";
			case PS4_CIRCLE:               "ps4_button_circle";
			case PS4_TRIANGLE:             "ps4_button_triangle";
			case PS4_SQUARE:               "ps4_button_square";
			case PS4_LEFTBUMPER:           "ps4_shoulder_l";
			case PS4_RIGHTBUMPER:          "ps4_shouldr_r";
			case PS4_OPTIONS:              "ps4_button_options";
			case PS4_SHARE:                "ps4_button_share";
			case PS4_LEFTPAD_TOUCH :       "ps4_pad_l_touch";
			case PS4_LEFTPAD_SWIPE:        "ps4_pad_l_swipe";
			case PS4_LEFTPAD_CLICK:        "ps4_pad_l_click";
			case PS4_LEFTPAD_DPADNORTH:    "ps4_pad_l_dpad_n";
			case PS4_LEFTPAD_DPADSOUTH:    "ps4_pad_l_dpad_s";
			case PS4_LEFTPAD_DPADWEST:     "ps4_pad_l_dpad_w";
			case PS4_LEFTPAD_DPADEAST:     "ps4_pad_l_dpad_e";
			case PS4_RIGHTPAD_TOUCH:       "ps4_pard_r_touch";
			case PS4_RIGHTPAD_SWIPE:       "ps4_pad_r_swipe";
			case PS4_RIGHTPAD_CLICK:       "ps4_pad_r_click";
			case PS4_RIGHTPAD_DPADNORTH:   "ps4_pad_r_dpad_n";
			case PS4_RIGHTPAD_DPADSOUTH:   "ps4_pad_r_dpad_s";
			case PS4_RIGHTPAD_DPADWEST:    "ps4_pad_r_dpad_w";
			case PS4_RIGHTPAD_DPADEAST:    "ps4_pad_r_dpad_e";
			case PS4_CENTERPAD_TOUCH :     "ps4_pad_center_touch";
			case PS4_CENTERPAD_SWIPE:      "ps4_pad_center_swipe";
			case PS4_CENTERPAD_CLICK:      "ps4_pad_center_click";
			case PS4_CENTERPAD_DPADNORTH:  "ps4_pad_center_dpad_n";
			case PS4_CENTERPAD_DPADSOUTH:  "ps4_pad_center_dpad_s";
			case PS4_CENTERPAD_DPADWEST:   "ps4_pad_center_dpad_w";
			case PS4_CENTERPAD_DPADEAST:   "ps4_pad_center_dpad_e";
			case PS4_LEFTTRIGGER_PULL:     "ps4_trigger_l_pull";
			case PS4_LEFTTRIGGER_CLICK:    "ps4_trigger_l_click";
			case PS4_RIGHTTRIGGER_PULL:    "ps4_trigger_r_pull";
			case PS4_RIGHTTRIGGER_CLICK:   "ps4_trigger_r_click";
			case PS4_LEFTSTICK_MOVE:       "ps4_stick_l_move";
			case PS4_LEFTSTICK_CLICK:      "ps4_stick_l_click";
			case PS4_LEFTSTICK_DPADNORTH:  "ps4_stick_l_dpad_n";
			case PS4_LEFTSTICK_DPADSOUTH:  "ps4_stick_l_dpad_s";
			case PS4_LEFTSTICK_DPADWEST:   "ps4_stick_l_dpad_w";
			case PS4_LEFTSTICK_DPADEAST:   "ps4_stick_l_dpad_e";
			case PS4_RIGHTSTICK_MOVE:      "ps4_stick_r_move";
			case PS4_RIGHTSTICK_CLICK:     "ps4_stick_r_click";
			case PS4_RIGHTSTICK_DPADNORTH: "ps4_stick_r_dpad_n";
			case PS4_RIGHTSTICK_DPADSOUTH: "ps4_stick_r_dpad_s";
			case PS4_RIGHTSTICK_DPADWEST:  "ps4_stick_r_dpad_w";
			case PS4_RIGHTSTICK_DPADEAST:  "ps4_stick_r_dpad_e";
			case PS4_DPAD_NORTH:           "ps4_button_dpad_n";
			case PS4_DPAD_SOUTH:           "ps4_button_dpad_s";
			case PS4_DPAD_WEST:            "ps4_button_dpad_w";
			case PS4_DPAD_EAST:            "ps4_button_dpad_e";
			case PS4_GYRO_MOVE:            "ps4_gyro";
			case PS4_GYRO_PITCH:           "ps4_gyro_pitch";
			case PS4_GYRO_YAW:             "ps4_gyro_yaw";
			case PS4_GYRO_ROLL:            "ps4_gyro_roll";

			//Microsoft XBox One:
			case XBOXONE_A:                    "xboxone_button_a";
			case XBOXONE_B:                    "xboxone_button_b";
			case XBOXONE_X:                    "xboxone_button_x";
			case XBOXONE_Y:                    "xboxone_button_y";
			case XBOXONE_LEFTBUMPER:           "xboxone_shoulder_l";
			case XBOXONE_RIGHTBUMPER:          "xboxone_shouldr_r";
			case XBOXONE_MENU:                 "xboxone_button_menu";
			case XBOXONE_VIEW:                 "xboxone_button_view";
			case XBOXONE_LEFTTRIGGER_PULL:     "xboxone_trigger_l_pull";
			case XBOXONE_LEFTTRIGGER_CLICK:    "xboxone_trigger_l_click";
			case XBOXONE_RIGHTTRIGGER_PULL:    "xboxone_trigger_r_pull";
			case XBOXONE_RIGHTTRIGGER_CLICK:   "xboxone_trigger_r_click";
			case XBOXONE_LEFTSTICK_MOVE:       "xboxone_stick_l_move";
			case XBOXONE_LEFTSTICK_CLICK:      "xboxone_stick_l_click";
			case XBOXONE_LEFTSTICK_DPADNORTH:  "xboxone_stick_l_dpad_n";
			case XBOXONE_LEFTSTICK_DPADSOUTH:  "xboxone_stick_l_dpad_s";
			case XBOXONE_LEFTSTICK_DPADWEST:   "xboxone_stick_l_dpad_w";
			case XBOXONE_LEFTSTICK_DPADEAST:   "xboxone_stick_l_dpad_e";
			case XBOXONE_RIGHTSTICK_MOVE:      "xboxone_stick_r_move";
			case XBOXONE_RIGHTSTICK_CLICK:     "xboxone_stick_r_click";
			case XBOXONE_RIGHTSTICK_DPADNORTH: "xboxone_stick_r_dpad_n";
			case XBOXONE_RIGHTSTICK_DPADSOUTH: "xboxone_stick_r_dpad_s";
			case XBOXONE_RIGHTSTICK_DPADWEST:  "xboxone_stick_r_dpad_w";
			case XBOXONE_RIGHTSTICK_DPADEAST:  "xboxone_stick_r_dpad_e";
			case XBOXONE_DPAD_NORTH:           "xboxone_button_dpad_n";
			case XBOXONE_DPAD_SOUTH:           "xboxone_button_dpad_s";
			case XBOXONE_DPAD_WEST:            "xboxone_button_dpad_w";
			case XBOXONE_DPAD_EAST:            "xboxone_button_dpad_e";

			//Microsoft XBox 360:
			case XBOX360_A:                    "xbox360_button_a";
			case XBOX360_B:                    "xbox360_button_b";
			case XBOX360_X:                    "xbox360_button_x";
			case XBOX360_Y:                    "xbox360_button_y";
			case XBOX360_LEFTBUMPER:           "xbox360_shoulder_l";
			case XBOX360_RIGHTBUMPER:          "xbox360_shouldr_r";
			case XBOX360_START:                "xbox360_button_start";
			case XBOX360_BACK:                 "xbox360_button_back";
			case XBOX360_LEFTTRIGGER_PULL:     "xbox360_trigger_l_pull";
			case XBOX360_LEFTTRIGGER_CLICK:    "xbox360_trigger_l_click";
			case XBOX360_RIGHTTRIGGER_PULL:    "xbox360_trigger_r_pull";
			case XBOX360_RIGHTTRIGGER_CLICK:   "xbox360_trigger_r_click";
			case XBOX360_LEFTSTICK_MOVE:       "xbox360_stick_l_move";
			case XBOX360_LEFTSTICK_CLICK:      "xbox360_stick_l_click";
			case XBOX360_LEFTSTICK_DPADNORTH:  "xbox360_stick_l_dpad_n";
			case XBOX360_LEFTSTICK_DPADSOUTH:  "xbox360_stick_l_dpad_s";
			case XBOX360_LEFTSTICK_DPADWEST:   "xbox360_stick_l_dpad_w";
			case XBOX360_LEFTSTICK_DPADEAST:   "xbox360_stick_l_dpad_e";
			case XBOX360_RIGHTSTICK_MOVE:      "xbox360_stick_r_move";
			case XBOX360_RIGHTSTICK_CLICK:     "xbox360_stick_r_click";
			case XBOX360_RIGHTSTICK_DPADNORTH: "xbox360_stick_r_dpad_n";
			case XBOX360_RIGHTSTICK_DPADSOUTH: "xbox360_stick_r_dpad_s";
			case XBOX360_RIGHTSTICK_DPADWEST:  "xbox360_stick_r_dpad_w";
			case XBOX360_RIGHTSTICK_DPADEAST:  "xbox360_stick_r_dpad_e";
			case XBOX360_DPAD_NORTH:           "xbox360_button_dpad_n";
			case XBOX360_DPAD_SOUTH:           "xbox360_button_dpad_s";
			case XBOX360_DPAD_WEST:            "xbox360_button_dpad_w";
			case XBOX360_DPAD_EAST:            "xbox360_button_dpad_e";

			default:                           "unknown";
		}
	}

}

/**
	A trackpad of the Steam Controller, for the haptic pulses.
**/
enum abstract ESteamControllerPad(Int) to Int {
	/**
		The left trackpad.
	**/
	public var LEFT = 0;
	/**
		The right trackpad.
	**/
	public var RIGHT = 1;
	/**
		Both trackpads.
	**/
	public var BOTH = 2;
}

/**
	A source of input of a controller (Steamworks `EControllerSource`).
**/
enum abstract EControllerSource(Int) to Int {
	/**
		No source.
	**/
	public var NONE = 0;
	/**
		The left trackpad.
	**/
	public var LEFTTRACKPAD = 1;
	/**
		The right trackpad.
	**/
	public var RIGHTTRACKPAD = 2;
	/**
		The joystick.
	**/
	public var JOYSTICK = 3;
	/**
		The face buttons.
	**/
	public var ABXY = 4;
	/**
		The bumpers, grips and menu buttons.
	**/
	public var SWITCH = 5;
	/**
		The left trigger.
	**/
	public var LEFTTRIGGER = 6;
	/**
		The right trigger.
	**/
	public var RIGHTTRIGGER = 7;
	/**
		The gyroscope.
	**/
	public var GYRO = 8;
	/**
		The number of sources.
	**/
	public var COUNT = 9;
}

/**
	How a source of input is used (Steamworks `EControllerSourceMode`).
**/
enum abstract EControllerSourceMode(Int) to Int {
	/**
		Not used.
	**/
	public var NONE = 0;
	/**
		As a D-pad.
	**/
	public var DPAD = 1;
	/**
		As buttons.
	**/
	public var BUTTONS = 2;
	/**
		As four buttons.
	**/
	public var FOURBUTTONS = 3;
	/**
		As an absolute mouse.
	**/
	public var ABSOLUTEMOUSE = 4;
	/**
		As a relative mouse.
	**/
	public var RELATIVEMOUSE = 5;
	/**
		As a joystick for movement.
	**/
	public var JOYSTICKMOVE = 6;
	/**
		As a joystick for the camera.
	**/
	public var JOYSTICKCAMERA = 7;
	/**
		As a scroll wheel.
	**/
	public var SCROLLWHEEL = 8;
	/**
		As a trigger.
	**/
	public var TRIGGER = 9;
	/**
		As a touch menu.
	**/
	public var TOUCHMENU = 10;
	/**
		As a mouse joystick.
	**/
	public var MOUSEJOYSTICK = 11;
	/**
		As a mouse region.
	**/
	public var MOUSEREGION = 12;
}

/**
	The number of lines of the gamepad text input.
**/
enum abstract EGamepadTextInputLineMode(Int) to Int {
	/**
		A single line.
	**/
	public var SINGLE_LINE = 0;
	/**
		Multiple lines.
	**/
	public var MULTIPLE_LINES = 1;
}

/**
	The kind of text of the gamepad text input.
**/
enum abstract EGamepadTextInputMode(Int) to Int {
	/**
		Normal text.
	**/
	public var NORMAL = 0;
	/**
		A password (hidden).
	**/
	public var PASSWORD = 1;
}


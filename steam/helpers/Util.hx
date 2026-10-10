package steam.helpers;

/**
	String conversion helpers.
**/
class Util {

	/**
		Returns `true` for `1` or `true` (any case), `false` otherwise.
	**/
	public static function boolify(str:String):Bool
	{
		str = str.toLowerCase();
		if (str == "1" || str == "true") return true;
		return false;
	}

	/**
		Parses a float, or returns `defaultValue`.
	**/
	public static function str2Float(str:String, defaultValue:Float=0.0):Float{
		var f = Std.parseFloat(str);
		if (Math.isNaN(f)) return defaultValue;
		else return f;
	}

	/**
		Parses an integer, or returns `defaultValue`.
	**/
	public static function str2Int(str:String, defaultValue:Int=0):Int{
		var i = Std.parseInt(str);
		if (i == null) return defaultValue;
		else return i;
	}
}
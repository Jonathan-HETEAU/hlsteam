package steam;
import haxe.io.Bytes;

/**
	Steam Cloud: the files of the user stored by Steam and synchronized between computers (Steamworks `ISteamRemoteStorage`).
**/

@:allow(steam.Api)
class Cloud {

	/**
		Returns the number of files.
	**/
	public static function count():Int {
		return _GetFileCount();
	}

	/**
		Tells if the file exists.
	**/
	public static function exists(name:String):Bool {
		return _FileExists(@:privateAccess name.toUtf8());
	}

	/**
		Returns the size of the file, in bytes.
	**/
	public static function size(name:String):Int {
		return _GetFileSize(@:privateAccess name.toUtf8());
	}

	/**
		Returns the total and available space, in bytes.
	**/
	public static function quota() : {total:Float, available:Float} {
		var total = 0., available = 0.;
		_GetQuota(total, available);
		return {total:total, available:available};
	}

	/**
		Returns the content of the file, or `null` if it doesn't exist.
	**/
	public static function read(name:String) : haxe.io.Bytes {
		if (!exists(name))
			return null;
		var len = 0;
		var fileData:hl.Bytes = _FileRead(@:privateAccess name.toUtf8(), len);
		if( fileData == null ) return null;
		return @:privateAccess new haxe.io.Bytes(fileData, len);
	}

	/**
		Shares the file publicly: `onResult` is called with the UID of the shared file, or `null` on error.
	**/
	public static function share(name:String, onResult : UID -> Void ) : AsyncCall {
		return _FileShare(@:privateAccess name.toUtf8(), function(uid, error){
			onResult( error ? null : uid );
		});
	}

	/**
		Writes the file. Returns `false` on error.
	**/
	public static function write(name:String, data:Bytes) : Bool {
		return _FileWrite(@:privateAccess name.toUtf8(), data.getData(), data.length);
	}

	/**
		Deletes the file. Returns `false` on error.
	**/
	public static function delete(name:String):Bool {
		return _FileDelete(@:privateAccess name.toUtf8());
	}

	/**
		Tells if Steam Cloud is enabled for the game and for the account.
	**/
	public static function isEnabled():Bool {
		return _IsCloudEnabledForApp() && _IsCloudEnabledForAccount();
	}

	/**
		Tells if the user enabled Steam Cloud for the game.
	**/
	public static function isEnabledForApp():Bool {
		return _IsCloudEnabledForApp();
	}

	/**
		Tells if Steam Cloud is enabled for the account.
	**/
	public static function isEnabledForAccount():Bool {
		return _IsCloudEnabledForAccount();
	}

	/**
		Enables or disables Steam Cloud for the game.
	**/
	public static function enable(b:Bool):Void {
		_SetCloudEnabledForApp(b);
	}

	/*************PRIVATE***************/


	@:hlNative("steam","file_read") private static function _FileRead( name : hl.Bytes, len : hl.Ref<Int> ) : hl.Bytes { return null; }
	@:hlNative("steam","file_write") private static function _FileWrite( name : hl.Bytes, bytes : hl.Bytes, len : Int ) : Bool { return false; }
	@:hlNative("steam","get_quota") private static function _GetQuota( total : hl.Ref<Float>, available : hl.Ref<Float> ): Void{};
	@:hlNative("steam","get_file_count") private static function _GetFileCount() : Int { return 0; }
	@:hlNative("steam","file_exists") private static function _FileExists( name : hl.Bytes ) : Bool { return false; }
	@:hlNative("steam","file_delete") private static function _FileDelete( name : hl.Bytes ) : Bool { return false; }
	@:hlNative("steam","get_file_size") private static function _GetFileSize( name : hl.Bytes ) : Int { return 0; }
	@:hlNative("steam","file_share") private static function _FileShare( name : hl.Bytes, onResult : Callback<UID> ): AsyncCall{ return null; };
	@:hlNative("steam","is_cloud_enabled_for_app") private static function _IsCloudEnabledForApp() : Bool { return false; }
	@:hlNative("steam","is_cloud_enabled_for_account") private static function _IsCloudEnabledForAccount() : Bool { return false; }
	@:hlNative("steam","set_cloud_enabled_for_app") private static function _SetCloudEnabledForApp( enabled : Bool ) : Void {};

}
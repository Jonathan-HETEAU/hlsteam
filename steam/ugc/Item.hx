package steam.ugc;
import steam.UID;

/**
	The state of a Workshop item on the computer (Steamworks `EItemState`).
**/
enum ItemState {
	/**
		The user is subscribed to the item.
	**/
	Subscribed;
	/**
		The item was created with the old Workshop API (`ISteamRemoteStorage`).
	**/
	LegacyItem;
	/**
		The item is installed.
	**/
	Installed;
	/**
		The item needs an update.
	**/
	NeedsUpdate;
	/**
		The item is being downloaded.
	**/
	Downloading;
	/**
		The download is scheduled.
	**/
	DownloadPending;
}

/**
	A Workshop item (Steamworks `PublishedFileId_t`).
**/
@:hlNative("steam")
class Item {

	/**
		The id of the item.
	**/
	public var id : UID;
	/**
		The functions called when an item was downloaded (see `init`).
	**/
	public static var downloadedCallbacks = new Array<Item->Void>();
	/**
		The functions called when an item was installed (see `init`).
	**/
	public static var installedCallbacks = new Array<Item->Void>();

	/**
		Returns the item of an id below 2^32.
	**/
	public static function fromInt( i : Int ){
		var b = haxe.io.Bytes.alloc(8);
		b.setInt32(0, i);
		return new Item(steam.UID.fromBytes(b));
	}

	/**
		Adds functions called when an item was downloaded and when an item was installed.
	**/
	public static function init( onDownloaded : Item -> Void, onInstalled : Item -> Void ){
		downloadedCallbacks.push(onDownloaded);
		installedCallbacks.push(onInstalled);
		Api.registerGlobalEvent(3400 + 6, function(data:{file:UID}){
			var item = new Item(data.file);
			for( callback in downloadedCallbacks ){
				callback(item);
			}
		});
		Api.registerGlobalEvent(3400 + 5, function(data:{file:UID}){
			var item = new Item(data.file);
			for( callback in installedCallbacks ){
				callback(item);
			}
		});
	}

	/**
		Creates a new item for the app: `cb` is called with the item (`null` on error) and whether the user must accept the Workshop legal agreement. Set its content with `ItemUpdate`.
	**/
	public static function create( appId : Int, cb : Null<Item> -> Bool -> Void ){
		ugc_item_create(appId,function(obj, error){
			if( error ){
				cb(null,false);
				return;
			}
			cb(new Item(obj.id), obj.userNeedsLegalAgreement);
		});
	}

	/**
		Returns the items the user is subscribed to, or `null`.
	**/
	public static function listSubscribed() : Array<Item> {
		var a = get_subscribed_items();
		return a == null ? null : [for( it in a ) new Item(it)];
	}

	inline function new( b : UID ){
		id = b;
	}

	/**
		Returns the state of the item.
	**/
	public function getState() : haxe.EnumFlags<ItemState> {
		return haxe.EnumFlags.ofInt( get_item_state(id) );
	}

	/**
		Returns the progress of the download, in bytes, or `null` if not downloading.
	**/
	public function getDownloadInfo() : {downloaded: Float, total: Float} {
		var downloaded = 0.;
		var total = 0.;

		if( !get_item_download_info(id, downloaded, total) )
			return null;
		return {
			downloaded: downloaded,
			total: total
		};
	}

	/**
		Returns the size, update time and folder of the installed item, or `null` if not installed.
	**/
	public function getInstallInfo(){
		var r = get_item_install_info(id);
		if( r == null ) return null;
		return {
			size: r.size,
			timestamp: r.time,
			path: @:privateAccess String.fromUTF8(r.path)
		};
	}

	/**
		Downloads or updates the item (see `init` to be notified). `highPriority` pauses the other downloads. Returns `false` on failure.
	**/
	public function download( highPriority : Bool ) : Bool {
		return download_item( id, highPriority );
	}

	/**
		Subscribes the user to the item (it is then downloaded): `cb` is called when done.
	**/
	public function subscribe( cb ){
		subscribe_item( id, cb );
	}

	/**
		Unsubscribes the user from the item: `cb` is called when done.
	**/
	public function unsubscribe( cb ){
		unsubscribe_item( id, cb );
	}

	/**
		Returns a description of the item.
	**/
	public function toString(){
		return 'UGCItem($id)';
	}
	
	/**
		Deletes the item: `cb` is called with the `EResult` and whether the call failed.
	**/
	public function delete( cb : Int -> Bool -> Void ) {
		return delete_item(id, cb);
	}
	
	/**
		Makes the item require the app (DLC): `cb` is called with the `EResult` and whether the call failed.
	**/
	public function addAppDependency( appId : Int, cb : Int -> Bool -> Void ) {
		return add_app_dependency(id, appId, cb);
	}

	/**
		Removes an app dependency of the item: `cb` is called with the `EResult` and whether the call failed.
	**/
	public function removeAppDependency( appId : Int, cb : Int -> Bool -> Void ) {
		return remove_app_dependency(id, appId, cb);
	}

	/**
		Requests the apps the item requires: `cb` is called with the `EResult` and the app ids, and whether the call failed.
	**/
	public function getAppDependencies( cb : { result : Int, deps : hl.NativeArray<Int> } -> Bool -> Void ) {
		return get_app_dependencies(id, cb);
	}
	

	// -- native

	static function ugc_item_create( appId : Int, cb : Callback<Dynamic> ) : AsyncCall {
		return null;
	}
	
	static function get_subscribed_items() : hl.NativeArray<UID> {
		return null;
	}

	static function get_item_state( item : UID ) : Int {
		return 0;
	}

	static function get_item_download_info( item : UID, downloaded : hl.Ref<hl.F64>, total : hl.Ref<hl.F64> ) : Bool {
		return false;
	}

	static function download_item( item : UID, hPriority: Bool ) : Bool {
		return false;
	}

	static function get_item_install_info( item : UID ) : Dynamic {
		return null;
	}
	
	static function subscribe_item( item : UID, cb : Callback<UID> ) : AsyncCall {
		return null;
	}

	static function unsubscribe_item( item : UID, cb : Callback<UID> ) : AsyncCall {
		return null;
	}

	static function delete_item( item : UID, cb : Callback<Int> ) : AsyncCall {
		return null;
	}

	static function add_app_dependency( item : UID, appId : Int, cb : Callback<Int> ) : AsyncCall {
		return null;
	}

	static function remove_app_dependency( item : UID, appId : Int, cb : Callback<Int> ) : AsyncCall {
		return null;
	}
	
	static function get_app_dependencies( item : UID, cb : Callback<Dynamic> ) : AsyncCall {
		return null;
	}

}


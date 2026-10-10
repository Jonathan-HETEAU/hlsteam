package steam.ugc;

import steam.UID;
import steam.ugc.Data;

/**
	A Workshop item returned by a `Query` (Steamworks `SteamUGCDetails_t`).
**/
class Result {

	/**
		The id of the item.
	**/
	public var id : UID;
	/**
		The item.
	**/
	public var item(get,never) : Item;
	/**
		The result of the query for this item.
	**/
	public var result : EResult;
	/**
		The type of the item.
	**/
	public var fileType : EFileType;
	/**
		The app that created the item.
	**/
	public var creatorApp : Int;
	/**
		The app that uses the item.
	**/
	public var consumerApp : Int;
	/**
		The title.
	**/
	public var title : String;
	/**
		The description.
	**/
	public var description : String;
	/**
		The user who created the item.
	**/
	public var owner : User;
	/**
		The creation time, in seconds since 1970.
	**/
	public var created : Int;
	/**
		The last update time, in seconds since 1970.
	**/
	public var updated : Int;
	/**
		The time the item was added to the user list, for `Query.userList` queries, in seconds since 1970.
	**/
	public var timeAddedToUserList : Int;
	/**
		The visibility.
	**/
	public var visibility : EItemVisibility;
	/**
		Tells if the item was banned.
	**/
	public var banned : Bool;
	/**
		Tells if the item was accepted for the game.
	**/
	public var acceptedForUse : Bool;
	/**
		The tags.
	**/
	public var tags : Array<String>;
	/**
		The preview image file.
	**/
	public var previewFile : UID;
	/**
		The size of the preview image, in bytes.
	**/
	public var previewFileSize : Int;
	/**
		The file of the item.
	**/
	public var file : UID;
	/**
		The name of the file.
	**/
	public var fileName : String;
	/**
		The size of the file, in bytes.
	**/
	public var fileSize : Int;
	/**
		The URL of the item, for links (web guides, videos).
	**/
	public var url : String;
	/**
		The number of up votes.
	**/
	public var votesUp : Int;
	/**
		The number of down votes.
	**/
	public var votesDown : Int;
	/**
		The score, from `0` to `1`.
	**/
	public var score : Float;
	/**
		The number of children (items of a collection).
	**/
	public var numChildren : Int;
	/**
		The key/value tags, if `Query.returnKeyValueTags` is set.
	**/
	public var keyValueTags : Array<{key: String, value: String}>;
	/**
		The metadata, if `Query.returnMetadata` is set.
	**/
	public var metadata : String;
	/**
		The children, if `Query.returnChildren` is set.
	**/
	public var children : Array<steam.ugc.Item>;

	function new( obj : Dynamic ){
		id = obj.id;
		result = obj.result;
		fileType = obj.fileType;
		creatorApp = obj.creatorApp;
		consumerApp = obj.consumerApp;
		title = @:privateAccess String.fromUTF8(obj.title);
		description = @:privateAccess String.fromUTF8(obj.description);
		owner = User.fromUID(obj.owner);
		created = obj.timeCreated;
		updated = obj.timeUpdated;
		timeAddedToUserList = obj.timeAddedToUserList;
		visibility = obj.visibility;
		banned = obj.banned;
		acceptedForUse = obj.acceptedForUse;
		tags = @:privateAccess String.fromUTF8(obj.tags).split(",");
		previewFile = obj.previewFile;
		previewFileSize = obj.previewFileSize;
		file = obj.file;
		fileName = @:privateAccess String.fromUTF8(obj.fileName);
		fileSize = obj.fileSize;
		url = @:privateAccess String.fromUTF8(obj.url);
		votesUp = obj.votesUp;
		votesDown = obj.votesDown;
		score = obj.score;
		numChildren = obj.numChildren;
		children = [];
	}

	inline public function get_item(){
		return @:privateAccess new Item(id);
	}

	/**
		Returns the value of a key/value tag, or `null`.
	**/
	public function getKeyValueTag( key : String ) : String {
		for( o in keyValueTags )
			if( o.key == key ) return o.value;
		return null;
	}
}

/**
	A query of Workshop items (Steamworks `UGCQueryHandle_t`): create it with `list`, `userList` or `details`, set its options, `send` it, read the results with `getResult`, then `close` it.
**/
@:hlNative("steam")
class Query {

	var id : UID;
	/**
		Returns the key/value tags of the items.
	**/
	public var returnKeyValueTags(default,set) : Bool;
	/**
		Returns the metadata of the items.
	**/
	public var returnMetadata(default,set) : Bool;
	/**
		Returns the children of the items (collections).
	**/
	public var returnChildren(default,set) : Bool;

	/**
		Tells if `send` was called.
	**/
	public var sent(default,null) : Bool = false;
	/**
		The number of results of this page.
	**/
	public var resultsReturned(default,null) : Int;
	/**
		The total number of results.
	**/
	public var totalResults(default,null) : Int;
	/**
		Tells if the results come from the local cache.
	**/
	public var cached(default,null) : Bool;

	/**
		Creates a query of all the items, ranked by `type`. `page` starts at `1` (50 results per page). Returns `null` on failure.
	**/
	public static function list( type : EQueryType, ugcType : EMatchingType, creatorApp : Int, consumerApp : Int, page : Int ) : Query {
		var id = ugc_query_create_all_request(type,ugcType,creatorApp,consumerApp,page);
		if( id == null ) return null;
		return new Query(id);
	}

	/**
		Creates a query of a list of items of a user. `page` starts at `1`. Returns `null` on failure.
	**/
	public static function userList( user : steam.User, listType : EUserList, ugcType : EMatchingType, order : EUserListSortOrder, creatorApp : Int, consumerApp : Int, page : Int ){
		var id = ugc_query_create_user_request(user.getID32(),listType,ugcType,order,creatorApp,consumerApp,page);
		if( id == null ) return null;
		return new Query(id);
	}

	/**
		Creates a query of the details of the items. Returns `null` on failure.
	**/
	public static function details( ids : Array<Item> ) : Query {
		var a = new hl.NativeArray(ids.length);
		for( i in 0...ids.length )
			a[i] = ids[i].id;
		var id = ugc_query_create_details_request(a);
		if( id == null ) return null;
		return new Query(id);
	}

	function new( b : UID ){
		id = b;
	}

	/**
		Sets the language of the titles and descriptions returned (Steam API language name).
	**/
	public function setLanguage( lang : String ){
		ugc_query_set_language(id,@:privateAccess lang.toUtf8());
	}

	/**
		Sets the text searched in the items.
	**/
	public function setSearchText( search : String ){
		ugc_query_set_search_text(id,@:privateAccess search.toUtf8());
	}

	/**
		Only returns the items having the tag.
	**/
	public function addRequiredTag( tag : String ){
		ugc_query_add_required_tag(id,@:privateAccess tag.toUtf8());
	}

	/**
		Only returns the items having the key/value tag.
	**/
	public function addRequiredKeyValueTag( key : String, value : String ){
		ugc_query_add_required_key_value_tag(id,@:privateAccess key.toUtf8(), @:privateAccess value.toUtf8());
	}

	/**
		Excludes the items having the tag.
	**/
	public function addExcludedTag( tag : String ){
		ugc_query_add_excluded_tag(id,@:privateAccess tag.toUtf8());
	}

	public function set_returnMetadata( b : Bool ){
		ugc_query_set_return_metadata(id,b);
		return returnMetadata = b;
	}

	public function set_returnKeyValueTags( b : Bool ){
		ugc_query_set_return_key_value_tags(id,b);
		return returnKeyValueTags = b;
	}

	public function set_returnChildren( b : Bool ){
		ugc_query_set_return_children(id,b);
		return returnChildren = b;
	}

	/**
		Sends the query: `cb` is called with `true` if it succeeded.
	**/
	public function send( cb : Bool -> Void ){
		sent = true;
		ugc_query_send_request(id,function(obj,error){
			if( !error ){
				resultsReturned = obj.resultsReturned;
				totalResults = obj.totalResults;
				cached = obj.cached;
			}
			cb(!error);
		});
	}

	/**
		Releases the query.
	**/
	public function close(){
		ugc_query_release_request(id);
	}

	/**
		Returns a result, from `0` to `resultsReturned - 1`, or `null`.
	**/
	public function getResult( index : Int ){
		var r = ugc_query_get_result(id,index);
		if( r == null ) return null;
		var res = @:privateAccess new Result(r);
		
		if( returnKeyValueTags ){
			var ntags = ugc_query_get_key_value_tags(id,index,0xFFFF);
			res.keyValueTags = [];
			var i = 0;
			while( i < ntags.length ) @:privateAccess {
				res.keyValueTags.push({
					key: String.fromUTF8( ntags[i++] ),
					value: String.fromUTF8( ntags[i++] )
				});
			}
		}

		if( returnMetadata ){
			var s = ugc_query_get_metadata(id,index);
			if( s != null ) res.metadata = @:privateAccess String.fromUTF8(s);
		}

		if( returnChildren && res.numChildren > 0 ){
			var r = ugc_query_get_children(id,index,res.numChildren);
			if( r != null ) res.children = [for( uid in r ) @:privateAccess new Item(uid)];
		}

		return res;
	}

	// -- native

	static function ugc_query_create_all_request( type : Int, ugcType : Int, creatorApp : Int, consumerApp : Int, page : Int ) : UID { return null; }
	static function ugc_query_create_user_request( user : Int, listType : Int, ugcType : Int, sortOrder : Int, creatorApp : Int, consumerApp : Int, page : Int ) : UID { return null; }
	static function ugc_query_create_details_request( fileIds : hl.NativeArray<UID> ) : UID { return null; }
	static function ugc_query_set_language( query : UID, lang : hl.Bytes ) : Bool { return false; }
	static function ugc_query_set_search_text( query : UID, search : hl.Bytes ) : Bool { return false; }
	static function ugc_query_add_required_tag( query : UID, tag : hl.Bytes ) : Bool { return false; }
	static function ugc_query_add_required_key_value_tag( query : UID, key : hl.Bytes, value : hl.Bytes ) : Bool { return false; }
	static function ugc_query_add_excluded_tag( query : UID, tag : hl.Bytes ) : Bool { return false; }
	static function ugc_query_set_return_metadata( query : UID, r : Bool ) : Bool { return false; }
	static function ugc_query_set_return_children( query : UID, r : Bool ) : Bool { return false; }
	static function ugc_query_set_return_key_value_tags( query : UID, r : Bool ) : Bool { return false; }
	static function ugc_query_send_request( query : UID, cb : Callback<Dynamic> ) : AsyncCall { return null; }
	static function ugc_query_release_request( query : UID ) : Bool { return false; }
	static function ugc_query_get_key_value_tags( query : UID, index : Int, maxValueLength : Int ) : hl.NativeArray<hl.Bytes> { return null; }
	static function ugc_query_get_children( query : UID, index : Int, numChildren : Int ) : hl.NativeArray<UID> { return null; }
	static function ugc_query_get_metadata( query : UID, index : Int ) : hl.Bytes { return null; }
	static function ugc_query_get_result( query : UID, index : Int ) : Dynamic { return null; }


}
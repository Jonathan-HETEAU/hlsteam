# steam.ugc.Query

**class** · package [`steam.ugc`](README.md) · source [`steam/ugc/Query.hx`](../../../../../steam/ugc/Query.hx)

A query of Workshop items (Steamworks `UGCQueryHandle_t`): create it with `list`, `userList` or `details`, set its options, `send` it, read the results with `getResult`, then `close` it.

## Static methods

### list

```haxe
static function list(type:EQueryType, ugcType:EMatchingType, creatorApp:Int, consumerApp:Int, page:Int):Query
```

Creates a query of all the items, ranked by `type`. `page` starts at `1` (50 results per page). Returns `null` on failure.

### userList

```haxe
static function userList(user:steam.User, listType:EUserList, ugcType:EMatchingType, order:EUserListSortOrder, creatorApp:Int, consumerApp:Int, page:Int):Null<Query>
```

Creates a query of a list of items of a user. `page` starts at `1`. Returns `null` on failure.

### details

```haxe
static function details(ids:Array<Item>):Query
```

Creates a query of the details of the items. Returns `null` on failure.

## Variables

### returnKeyValueTags

```haxe
var returnKeyValueTags(default, set):Bool
```

Returns the key/value tags of the items.

### returnMetadata

```haxe
var returnMetadata(default, set):Bool
```

Returns the metadata of the items.

### returnChildren

```haxe
var returnChildren(default, set):Bool
```

Returns the children of the items (collections).

### sent

```haxe
var sent(default, null):Bool
```

Tells if `send` was called.

### resultsReturned

```haxe
var resultsReturned(default, null):Int
```

The number of results of this page.

### totalResults

```haxe
var totalResults(default, null):Int
```

The total number of results.

### cached

```haxe
var cached(default, null):Bool
```

Tells if the results come from the local cache.

## Methods

### setLanguage

```haxe
function setLanguage(lang:String):Void
```

Sets the language of the titles and descriptions returned (Steam API language name).

### setSearchText

```haxe
function setSearchText(search:String):Void
```

Sets the text searched in the items.

### addRequiredTag

```haxe
function addRequiredTag(tag:String):Void
```

Only returns the items having the tag.

### addRequiredKeyValueTag

```haxe
function addRequiredKeyValueTag(key:String, value:String):Void
```

Only returns the items having the key/value tag.

### addExcludedTag

```haxe
function addExcludedTag(tag:String):Void
```

Excludes the items having the tag.

### set_returnMetadata

```haxe
function set_returnMetadata(b:Bool):Bool
```

### set_returnKeyValueTags

```haxe
function set_returnKeyValueTags(b:Bool):Bool
```

### set_returnChildren

```haxe
function set_returnChildren(b:Bool):Bool
```

### send

```haxe
function send(cb:() -> Void):Void
```

Sends the query: `cb` is called with `true` if it succeeded.

### close

```haxe
function close():Void
```

Releases the query.

### getResult

```haxe
function getResult(index:Int):Null<Result>
```

Returns a result, from `0` to `resultsReturned - 1`, or `null`.

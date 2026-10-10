# steam.ugc.Result

**class** · package [`steam.ugc`](README.md) · module `steam.ugc.Query` · source [`steam/ugc/Query.hx`](../../../../../steam/ugc/Query.hx)

A Workshop item returned by a `Query` (Steamworks `SteamUGCDetails_t`).

## Variables

### id

```haxe
var id:steam.UID
```

The id of the item.

### item

```haxe
var item(get, null):Item
```

The item.

### result

```haxe
var result:EResult
```

The result of the query for this item.

### fileType

```haxe
var fileType:EFileType
```

The type of the item.

### creatorApp

```haxe
var creatorApp:Int
```

The app that created the item.

### consumerApp

```haxe
var consumerApp:Int
```

The app that uses the item.

### title

```haxe
var title:String
```

The title.

### description

```haxe
var description:String
```

The description.

### owner

```haxe
var owner:steam.User
```

The user who created the item.

### created

```haxe
var created:Int
```

The creation time, in seconds since 1970.

### updated

```haxe
var updated:Int
```

The last update time, in seconds since 1970.

### timeAddedToUserList

```haxe
var timeAddedToUserList:Int
```

The time the item was added to the user list, for `Query.userList` queries, in seconds since 1970.

### visibility

```haxe
var visibility:EItemVisibility
```

The visibility.

### banned

```haxe
var banned:Bool
```

Tells if the item was banned.

### acceptedForUse

```haxe
var acceptedForUse:Bool
```

Tells if the item was accepted for the game.

### tags

```haxe
var tags:Array<String>
```

The tags.

### previewFile

```haxe
var previewFile:steam.UID
```

The preview image file.

### previewFileSize

```haxe
var previewFileSize:Int
```

The size of the preview image, in bytes.

### file

```haxe
var file:steam.UID
```

The file of the item.

### fileName

```haxe
var fileName:String
```

The name of the file.

### fileSize

```haxe
var fileSize:Int
```

The size of the file, in bytes.

### url

```haxe
var url:String
```

The URL of the item, for links (web guides, videos).

### votesUp

```haxe
var votesUp:Int
```

The number of up votes.

### votesDown

```haxe
var votesDown:Int
```

The number of down votes.

### score

```haxe
var score:Float
```

The score, from `0` to `1`.

### numChildren

```haxe
var numChildren:Int
```

The number of children (items of a collection).

### keyValueTags

```haxe
var keyValueTags:Array<{ value:String, key:String }>
```

The key/value tags, if `Query.returnKeyValueTags` is set.

### metadata

```haxe
var metadata:String
```

The metadata, if `Query.returnMetadata` is set.

### children

```haxe
var children:Array<Item>
```

The children, if `Query.returnChildren` is set.

## Methods

### get_item

```haxe
inline function get_item():Item
```

### getKeyValueTag

```haxe
function getKeyValueTag(key:String):String
```

Returns the value of a key/value tag, or `null`.

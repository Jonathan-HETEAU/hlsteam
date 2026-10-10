# steam.ugc.ItemUpdate

**class** · package [`steam.ugc`](README.md) · source [`steam/ugc/ItemUpdate.hx`](../../../../../steam/ugc/ItemUpdate.hx)

An update of a Workshop item: set the changes, then `submit` it (Steamworks `UGCUpdateHandle_t`).

## Static methods

### start

```haxe
static function start(appId:Int, item:steam.UID):ItemUpdate
```

Starts an update of the item of the app, or returns `null`.

## Methods

### submit

```haxe
function submit(notes:String, cb:(Bool, Dynamic) -> Void):steam.AsyncCall
```

Submits the update, with change notes (or `null`): `cb` is called with `true` on success, and whether the user must accept the Workshop legal agreement.

### setUpdateLanguage

```haxe
function setUpdateLanguage(lang:String):Bool
```

Sets the language of the title and description (Steam API language name).

### setTitle

```haxe
function setTitle(title:String):Bool
```

Sets the title.

### setDescription

```haxe
function setDescription(desc:String):Bool
```

Sets the description.

### setMetadata

```haxe
function setMetadata(metadata:String):Bool
```

Sets the metadata, data for the game (up to 5000 bytes).

### setTags

```haxe
function setTags(tags:Array<String>):Bool
```

Sets the tags.

### addKeyValueTag

```haxe
function addKeyValueTag(key:String, value:String):Bool
```

Adds a key/value tag.

### removeKeyValueTag

```haxe
function removeKeyValueTag(key:String):Bool
```

Removes the key/value tags of the key.

### setVisibility

```haxe
function setVisibility(visibility:EItemVisibility):Bool
```

Sets the visibility.

### setContent

```haxe
function setContent(path:String):Bool
```

Sets the folder whose content is uploaded as the item.

### setPreviewImage

```haxe
function setPreviewImage(path:String):Bool
```

Sets the preview image file.

# steam.ugc.Item

**class** · package [`steam.ugc`](README.md) · source [`steam/ugc/Item.hx`](../../../../../steam/ugc/Item.hx)

A Workshop item (Steamworks `PublishedFileId_t`).

## Static variables

### downloadedCallbacks

```haxe
static var downloadedCallbacks:Array<() -> Void>
```

The functions called when an item was downloaded (see `init`).

### installedCallbacks

```haxe
static var installedCallbacks:Array<() -> Void>
```

The functions called when an item was installed (see `init`).

## Static methods

### fromInt

```haxe
static function fromInt(i:Int):Item
```

Returns the item of an id below 2^32.

### init

```haxe
static function init(onDownloaded:() -> Void, onInstalled:() -> Void):Void
```

Adds functions called when an item was downloaded and when an item was installed.

### create

```haxe
static function create(appId:Int, cb:(Null<Item>, Bool) -> Void):Void
```

Creates a new item for the app: `cb` is called with the item (`null` on error) and whether the user must accept the Workshop legal agreement. Set its content with `ItemUpdate`.

### listSubscribed

```haxe
static function listSubscribed():Array<Item>
```

Returns the items the user is subscribed to, or `null`.

## Variables

### id

```haxe
var id:steam.UID
```

The id of the item.

## Methods

### getState

```haxe
function getState():EnumFlags<ItemState>
```

Returns the state of the item.

### getDownloadInfo

```haxe
function getDownloadInfo():{ total:Float, downloaded:Float }
```

Returns the progress of the download, in bytes, or `null` if not downloading.

### getInstallInfo

```haxe
function getInstallInfo():Null<{ timestamp:Dynamic, size:Dynamic, path:String }>
```

Returns the size, update time and folder of the installed item, or `null` if not installed.

### download

```haxe
function download(highPriority:Bool):Bool
```

Downloads or updates the item (see `init` to be notified). `highPriority` pauses the other downloads. Returns `false` on failure.

### subscribe

```haxe
function subscribe(cb:steam.Callback<steam.UID>):Void
```

Subscribes the user to the item (it is then downloaded): `cb` is called when done.

### unsubscribe

```haxe
function unsubscribe(cb:steam.Callback<steam.UID>):Void
```

Unsubscribes the user from the item: `cb` is called when done.

### toString

```haxe
function toString():String
```

Returns a description of the item.

### delete

```haxe
function delete(cb:(Int, Bool) -> Void):steam.AsyncCall
```

Deletes the item: `cb` is called with the `EResult` and whether the call failed.

### addAppDependency

```haxe
function addAppDependency(appId:Int, cb:(Int, Bool) -> Void):steam.AsyncCall
```

Makes the item require the app (DLC): `cb` is called with the `EResult` and whether the call failed.

### removeAppDependency

```haxe
function removeAppDependency(appId:Int, cb:(Int, Bool) -> Void):steam.AsyncCall
```

Removes an app dependency of the item: `cb` is called with the `EResult` and whether the call failed.

### getAppDependencies

```haxe
function getAppDependencies(cb:({ result:Int, deps:hl.NativeArray<Int> }, Bool) -> Void):steam.AsyncCall
```

Requests the apps the item requires: `cb` is called with the `EResult` and the app ids, and whether the call failed.

# steam.ugc.ItemState

**enum** · package [`steam.ugc`](README.md) · module `steam.ugc.Item` · source [`steam/ugc/Item.hx`](../../../../../steam/ugc/Item.hx)

The state of a Workshop item on the computer (Steamworks `EItemState`).

## Constructors

### Subscribed

```haxe
Subscribed
```

The user is subscribed to the item.

### LegacyItem

```haxe
LegacyItem
```

The item was created with the old Workshop API (`ISteamRemoteStorage`).

### Installed

```haxe
Installed
```

The item is installed.

### NeedsUpdate

```haxe
NeedsUpdate
```

The item needs an update.

### Downloading

```haxe
Downloading
```

The item is being downloaded.

### DownloadPending

```haxe
DownloadPending
```

The download is scheduled.

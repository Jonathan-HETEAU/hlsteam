# Package `steam.ugc`

[← API index](../../README.md)

| Type | Kind | Summary |
|---|---|---|
| [`EFileType`](EFileType.md) | enum abstract | The type of a Workshop item (Steamworks `EWorkshopFileType`). |
| [`EItemVisibility`](EItemVisibility.md) | enum abstract | The visibility of a Workshop item (Steamworks `ERemoteStoragePublishedFileVisibility`). |
| [`EMatchingType`](EMatchingType.md) | enum abstract | The kind of Workshop items returned by a query (Steamworks `EUGCMatchingUGCType`). |
| [`EQueryType`](EQueryType.md) | enum abstract | How the items of a Workshop query of all the items are ranked (Steamworks `EUGCQuery`). |
| [`EResult`](EResult.md) | enum abstract | The result of a Steam operation (Steamworks `EResult`). |
| [`EUserList`](EUserList.md) | enum abstract | The list of items of a user, for a Workshop query (Steamworks `EUserUGCList`). |
| [`EUserListSortOrder`](EUserListSortOrder.md) | enum abstract | The order of the items of a user list query (Steamworks `EUserUGCListSortOrder`). |
| [`Item`](Item.md) | class | A Workshop item (Steamworks `PublishedFileId_t`). |
| [`ItemState`](ItemState.md) | enum | The state of a Workshop item on the computer (Steamworks `EItemState`). |
| [`ItemUpdate`](ItemUpdate.md) | class | An update of a Workshop item: set the changes, then `submit` it (Steamworks `UGCUpdateHandle_t`). |
| [`Query`](Query.md) | class | A query of Workshop items (Steamworks `UGCQueryHandle_t`): create it with `list`, `userList` or `details`, set its options, `send` it, read the results with `getResult`, then `close` it. |
| [`Result`](Result.md) | class | A Workshop item returned by a `Query` (Steamworks `SteamUGCDetails_t`). |

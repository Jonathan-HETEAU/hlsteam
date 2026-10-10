# Package `steam.ugc`

[← retour](../DEPENDENCIES.md)

## steam.ugc.Data

- Fichier : `steam/ugc/Data.hx` — 511 lignes — 180 blocs doc
- Types : `enum_abstract EFileType`, `enum_abstract EQueryType`, `enum_abstract EMatchingType`, `enum_abstract EResult`, `enum_abstract EItemVisibility`, `enum_abstract EUserList`, `enum_abstract EUserListSortOrder`
- Utilisé par : `steam.ugc.ItemUpdate`, `steam.ugc.Query`

## steam.ugc.Item

- Fichier : `steam/ugc/Item.hx` — 251 lignes — 26 blocs doc
- Types : `enum ItemState`, `class Item`
- Dépend de : `steam.Api`, `steam.AsyncCall`, `steam.Callback`, `steam.UID` (import/use)
- Utilisé par : `steam.ugc.Query`

## steam.ugc.ItemUpdate

- Fichier : `steam/ugc/ItemUpdate.hx` — 120 lignes — 13 blocs doc
- Types : `class ItemUpdate`
- Dépend de : `steam.AsyncCall`, `steam.Callback`, `steam.UID`, `steam.ugc.Data` (import/use)

## steam.ugc.Query

- Fichier : `steam/ugc/Query.hx` — 368 lignes — 50 blocs doc
- Types : `class Result`, `class Query`
- Dépend de : `steam.AsyncCall`, `steam.Callback`, `steam.UID` (import/use), `steam.User`, `steam.ugc.Data` (import/use), `steam.ugc.Item`

# steam.ugc.EMatchingType

**enum abstract** · package [`steam.ugc`](README.md) · module `steam.ugc.Data` · source [`steam/ugc/Data.hx`](../../../../../steam/ugc/Data.hx)

The kind of Workshop items returned by a query (Steamworks `EUGCMatchingUGCType`).

Underlying type: `Int`

Implicit casts from: `Int`

Implicit casts to: `Int`

## Values

| Name | Value | Description |
|---|---|---|
| `Items` | `0` | both mtx items and ready-to-use items |
| `Items_Mtx` | `1` | Microtransaction items. |
| `Items_ReadyToUse` | `2` | Ready-to-use items. |
| `Collections` | `3` | Collections. |
| `Artwork` | `4` | Artwork. |
| `Videos` | `5` | Videos. |
| `Screenshots` | `6` | Screenshots. |
| `AllGuides` | `7` | both web quides and integrated guides |
| `WebGuides` | `8` | Web guides. |
| `IntegratedGuides` | `9` | Guides integrated in the game. |
| `UsableInGame` | `10` | ready-to-use items and integrated guides |
| `ControllerBindings` | `11` | Steam Input controller bindings. |
| `GameManagedItems` | `12` | game managed items (not managed by users) |
| `All` | `~0` | return everything |

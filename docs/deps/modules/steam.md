# Package `steam`

[← retour](../DEPENDENCIES.md)

## steam.Api

- Fichier : `steam/Api.hx` — 766 lignes — 66 blocs doc
- Types : `enum LeaderboardOp`, `enum_abstract SteamNotificationPosition`, `typedef ControllerHandle`, `typedef ControllerActionSetHandle`, `typedef ControllerDigitalActionHandle`, `typedef ControllerAnalogActionHandle`, `enum_abstract EventType`, `class Api`, `class LeaderboardScore`
- Dépend de : `steam.Controller`, `steam.UID`, `steam.User`, `steam.helpers.Util` (import/use)
- Utilisé par : `steam.Cloud`, `steam.Controller`, `steam.GameServer`, `steam.Matchmaking`, `steam.Networking`, `steam.ugc.Item`

## steam.AsyncCall

- Fichier : `steam/AsyncCall.hx` — 25 lignes — 2 blocs doc
- Types : `typedef AsyncData`, `abstract AsyncCall`
- Utilisé par : `steam.Cloud`, `steam.Lobby`, `steam.Matchmaking`, `steam.ugc.Item`, `steam.ugc.ItemUpdate`, `steam.ugc.Query`

## steam.Callback

- Fichier : `steam/Callback.hx` — 8 lignes — 1 blocs doc
- Types : `typedef Callback`
- Utilisé par : `steam.Cloud`, `steam.Lobby`, `steam.Matchmaking`, `steam.ugc.Item`, `steam.ugc.ItemUpdate`, `steam.ugc.Query`

## steam.Cloud

- Fichier : `steam/Cloud.hx` — 119 lignes — 14 blocs doc
- Types : `class Cloud`
- Dépend de : `steam.Api`, `steam.AsyncCall`, `steam.Callback`, `steam.UID`

## steam.Controller

- Fichier : `steam/Controller.hx` — 1665 lignes — 220 blocs doc
- Types : `class Controller`, `abstract ControllerDigitalActionData`, `class ControllerAnalogActionData`, `class ControllerMotionData`, `class ESteamControllerLEDFlags`, `enum_abstract EControllerActionOrigin`, `enum_abstract ESteamControllerPad`, `enum_abstract EControllerSource`, `enum_abstract EControllerSourceMode`, `enum_abstract EGamepadTextInputLineMode`, `enum_abstract EGamepadTextInputMode`
- Dépend de : `steam.Api`, `steam.helpers.MacroHelper` (import/use)
- Utilisé par : `steam.Api`

## steam.Friends

- Fichier : `steam/Friends.hx` — 213 lignes — 43 blocs doc
- Types : `enum_abstract FriendFlags`, `enum_abstract OverlayKind`, `enum_abstract OverlayToStoreFlag`, `class Friends`
- Dépend de : `steam.UID`, `steam.User`

## steam.GameServer

- Fichier : `steam/GameServer.hx` — 199 lignes — 16 blocs doc
- Types : `enum_abstract ServerMode`, `class GameServer`
- Dépend de : `steam.Api`, `steam.UID`
- Utilisé par : `steam.User`

## steam.Lobby

- Fichier : `steam/Lobby.hx` — 347 lignes — 41 blocs doc
- Types : `enum_abstract ChatMessageType`, `class Lobby`
- Dépend de : `steam.AsyncCall`, `steam.Callback`, `steam.Matchmaking`, `steam.UID`, `steam.User`
- Utilisé par : `steam.Matchmaking`

## steam.Matchmaking

- Fichier : `steam/Matchmaking.hx` — 277 lignes — 27 blocs doc
- Types : `enum_abstract LobbyKind`, `enum_abstract ComparisonFilter`, `enum_abstract DistanceFilter`, `enum LobbyChatFlag`, `typedef LobbyListFilters`, `class Matchmaking`
- Dépend de : `steam.Api`, `steam.AsyncCall`, `steam.Callback`, `steam.Lobby`, `steam.UID`, `steam.User`
- Utilisé par : `steam.Lobby`

## steam.Networking

- Fichier : `steam/Networking.hx` — 339 lignes — 31 blocs doc
- Types : `typedef NetworkApi`, `enum_abstract NetworkStatus`, `enum_abstract PacketType`, `typedef NetworkSessionData`, `typedef ThreadData`, `class Networking`
- Dépend de : `steam.Api`, `steam.UID`, `steam.User`

## steam.Timeline

- Fichier : `steam/Timeline.hx` — 142 lignes — 23 blocs doc
- Types : `enum_abstract ETimelineGameMode`, `enum_abstract ETimelineEventClipPriority`, `typedef TimelineEventHandle`, `class Timeline`, `class TimelineNative`

## steam.UID

- Fichier : `steam/UID.hx` — 47 lignes — 6 blocs doc
- Types : `abstract UID`
- Utilisé par : `steam.Api`, `steam.Cloud`, `steam.Friends`, `steam.GameServer`, `steam.Lobby`, `steam.Matchmaking`, `steam.Networking`, `steam.User`, `steam.ugc.Item`, `steam.ugc.ItemUpdate`, `steam.ugc.Query`

## steam.User

- Fichier : `steam/User.hx` — 202 lignes — 29 blocs doc — contient du `#if`
- Types : `enum Changed`, `enum AvatarSize`, `class User`
- Dépend de : `steam.GameServer`, `steam.UID`
- Utilisé par : `steam.Api`, `steam.Friends`, `steam.Lobby`, `steam.Matchmaking`, `steam.Networking`, `steam.ugc.Query`

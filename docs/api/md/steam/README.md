# Package `steam`

[← API index](../README.md)

Sub-packages: [`steam.data`](data/README.md), [`steam.helpers`](helpers/README.md), [`steam.ugc`](ugc/README.md)

| Type | Kind | Summary |
|---|---|---|
| [`Api`](Api.md) | class | The entry point of the Steam API: call `init` at startup, then use the functions of this class (achievements, stats, leaderboards, overlay, ownership) and of the other classes of the `steam` package. |
| [`AsyncCall`](AsyncCall.md) | abstract | A pending asynchronous Steam call: its callback is called when it completes, unless it is cancelled. |
| [`AvatarSize`](AvatarSize.md) | enum | The size of an avatar image. |
| [`Callback`](Callback.md) | typedef | The callback of an asynchronous Steam call: the result, and `true` if the call failed. |
| [`Changed`](Changed.md) | enum | The information of a user that changed (Steamworks `EPersonaChange`), given to the `User.requestInformation` callback. |
| [`ChatMessageType`](ChatMessageType.md) | enum abstract | The type of a lobby chat message (Steamworks `EChatEntryType`). |
| [`Cloud`](Cloud.md) | class | Steam Cloud: the files of the user stored by Steam and synchronized between computers (Steamworks `ISteamRemoteStorage`). |
| [`ComparisonFilter`](ComparisonFilter.md) | enum abstract | A comparison of a lobby list filter (Steamworks `ELobbyComparison`): how the lobby value compares to the filter value. |
| [`Controller`](Controller.md) | class | * The Steam Controller API. |
| [`ControllerActionSetHandle`](ControllerActionSetHandle.md) | typedef | A handle of a controller action set. |
| [`ControllerAnalogActionData`](ControllerAnalogActionData.md) | class | The state of an analog action. |
| [`ControllerAnalogActionHandle`](ControllerAnalogActionHandle.md) | typedef | A handle of an analog controller action. |
| [`ControllerDigitalActionData`](ControllerDigitalActionData.md) | abstract | The state of a digital action. |
| [`ControllerDigitalActionHandle`](ControllerDigitalActionHandle.md) | typedef | A handle of a digital (button) controller action. |
| [`ControllerHandle`](ControllerHandle.md) | typedef | A handle of a connected controller (Steam Input). |
| [`ControllerMotionData`](ControllerMotionData.md) | class | The motion data of a controller. |
| [`DistanceFilter`](DistanceFilter.md) | enum abstract | The geographic distance of the lobbies to list (Steamworks `ELobbyDistanceFilter`). |
| [`EControllerActionOrigin`](EControllerActionOrigin.md) | enum abstract | A physical input of a controller bound to an action (Steamworks `EControllerActionOrigin`). |
| [`EControllerSource`](EControllerSource.md) | enum abstract | A source of input of a controller (Steamworks `EControllerSource`). |
| [`EControllerSourceMode`](EControllerSourceMode.md) | enum abstract | How a source of input is used (Steamworks `EControllerSourceMode`). |
| [`EGamepadTextInputLineMode`](EGamepadTextInputLineMode.md) | enum abstract | The number of lines of the gamepad text input. |
| [`EGamepadTextInputMode`](EGamepadTextInputMode.md) | enum abstract | The kind of text of the gamepad text input. |
| [`ESteamControllerLEDFlags`](ESteamControllerLEDFlags.md) | class | The flags of `Controller.setLEDColor`. |
| [`ESteamControllerPad`](ESteamControllerPad.md) | enum abstract | A trackpad of the Steam Controller, for the haptic pulses. |
| [`ETimelineEventClipPriority`](ETimelineEventClipPriority.md) | enum abstract | Whether a timeline event is a good candidate for a clip (Steamworks `ETimelineEventClipPriority`). |
| [`ETimelineGameMode`](ETimelineGameMode.md) | enum abstract | The mode of the game shown in the Steam timeline (Steamworks `ETimelineGameMode`). |
| [`EventType`](EventType.md) | enum abstract | The events sent by the native library to `Api` (handled internally). |
| [`FriendFlags`](FriendFlags.md) | enum abstract | The relationships to list with `Friends.getFriends` (Steamworks `EFriendFlags`), combined with `\|`. |
| [`Friends`](Friends.md) | class | The friends of the user, the overlay dialogs and the rich presence (Steamworks `ISteamFriends`). |
| [`GameServer`](GameServer.md) | class | A dedicated game server registered on Steam (Steamworks `SteamGameServer`), and the list of the servers. |
| [`LeaderboardScore`](LeaderboardScore.md) | class | A leaderboard score. |
| [`Lobby`](Lobby.md) | class | A Steam lobby: a group of users sharing key/value data and chat messages, used to gather players before a game. |
| [`LobbyKind`](LobbyKind.md) | enum abstract | The visibility of a lobby (Steamworks `ELobbyType`). |
| [`LobbyListFilters`](LobbyListFilters.md) | typedef | The filters of `Matchmaking.requestLobbyList`. |
| [`Matchmaking`](Matchmaking.md) | class | The lobbies: creation, search and invitations (Steamworks `ISteamMatchmaking`). |
| [`NetworkApi`](NetworkApi.md) | typedef | The callbacks of the peer-to-peer networking, given to `Networking.startP2P`. |
| [`NetworkSessionData`](NetworkSessionData.md) | typedef | The state of a peer-to-peer session with a user (Steamworks `P2PSessionState_t`). |
| [`NetworkStatus`](NetworkStatus.md) | enum abstract | The error of a peer-to-peer connection (Steamworks `EP2PSessionError`). |
| [`Networking`](Networking.md) | class | The peer-to-peer networking between users (Steamworks `ISteamNetworking`): packets are sent to a user with `sendP2P`, and received by the `NetworkApi` given to `startP2P`. |
| [`OverlayKind`](OverlayKind.md) | enum abstract | A dialog of the Steam overlay, opened with `Friends.activateOverlay`. |
| [`OverlayToStoreFlag`](OverlayToStoreFlag.md) | enum abstract | What to do when opening the store page in the overlay (Steamworks `EOverlayToStoreFlag`). |
| [`PacketType`](PacketType.md) | enum abstract | How a packet is sent (Steamworks `EP2PSend`). |
| [`ServerMode`](ServerMode.md) | enum abstract | The authentication mode of a game server (Steamworks `EServerMode`). |
| [`SteamNotificationPosition`](SteamNotificationPosition.md) | enum abstract | A corner of the screen where the Steam notifications appear. |
| [`Timeline`](Timeline.md) | class | The Steam timeline of the game recordings (Steamworks `ISteamTimeline`): game modes, tooltips and events marking the important moments. |
| [`TimelineEventHandle`](TimelineEventHandle.md) | typedef | A handle of a timeline event. |
| [`TimelineNative`](TimelineNative.md) | class | The native functions of `Timeline`. |
| [`UID`](UID.md) | abstract | A 64 bits Steam identifier (`CSteamID`: user, lobby, game server...) or Workshop file identifier, stored as 8 bytes. |
| [`User`](User.md) | class | A Steam user. |

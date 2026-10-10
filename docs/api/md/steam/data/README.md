# Package `steam.data`

[← API index](../../README.md)

| Type | Kind | Summary |
|---|---|---|
| [`AnalogInputMode`](AnalogInputMode.md) | enum | The input mode of a stick, pad or gyro action. |
| [`AnalogTriggerAction`](AnalogTriggerAction.md) | typedef | An analog trigger action. |
| [`ButtonAction`](ButtonAction.md) | typedef | A digital (button) action. |
| [`ControllerActionSet`](ControllerActionSet.md) | typedef | An action set: the actions available in a context of the game (menu, gameplay...). |
| [`ControllerActionType`](ControllerActionType.md) | enum | The type of a controller action. |
| [`ControllerConfig`](ControllerConfig.md) | class | * A strongly-typed data structure representation of the "game_actions_xyz.vdf" * file Steam uses to define controller inputs for your game. |
| [`ControllerLocalization`](ControllerLocalization.md) | typedef | The localized texts of a language. |
| [`Locale`](Locale.md) | enum abstract | A language name of the Steam API (as returned by `steam.Api.getCurrentGameLanguage`). |
| [`ObjNum`](ObjNum.md) | typedef | An object parsed by `VDF`, with the position after it. |
| [`StickPadGyroAction`](StickPadGyroAction.md) | typedef | A stick, pad or gyro action. |
| [`StrNum`](StrNum.md) | typedef | A string parsed by `VDF`, with the position after it. |
| [`VDF`](VDF.md) | class | Parses the Valve Data Format (VDF, used by the Steam configuration files) into an object (port of the vdf library by Anthony Garcia). |

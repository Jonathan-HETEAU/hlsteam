# steam.EventType

**enum abstract** · package [`steam`](README.md) · module `steam.Api` · source [`steam/Api.hx`](../../../../steam/Api.hx)

The events sent by the native library to `Api` (handled internally).

Underlying type: `Int`

## Values

| Name | Value | Description |
|---|---|---|
| `None` | `0` | No event. |
| `GamepadTextInputDismissed` | `1` | The gamepad text input was closed (see `Api.whenGamepadTextInputDismissed`). |
| `UserStatsReceived` | `2` | The stats and achievements of the user were received. |
| `UserStatsStored` | `3` | The stats were stored (retried if it failed). |
| `UserAchievementStored` | `4` | An achievement was stored (see `Api.whenAchievementStored`). |
| `LeaderboardFound` | `5` | A leaderboard was found. |
| `ScoreUploaded` | `6` | A leaderboard score was uploaded (see `Api.whenLeaderboardScoreUploaded`). |
| `ScoreDownloaded` | `7` | Leaderboard scores were downloaded (see `Api.whenLeaderboardScoreDownloaded`). |
| `GlobalStatsReceived` | `8` | The global stats were received. |

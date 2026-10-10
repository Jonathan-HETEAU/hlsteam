# steam.ETimelineEventClipPriority

**enum abstract** · package [`steam`](README.md) · module `steam.Timeline` · source [`steam/Timeline.hx`](../../../../steam/Timeline.hx)

Whether a timeline event is a good candidate for a clip (Steamworks `ETimelineEventClipPriority`).

Underlying type: `Int`

Implicit casts from: `Int`

Implicit casts to: `Int`

## Values

| Name | Value | Description |
|---|---|---|
| `Invalid` | `0` | Invalid. |
| `None` | `1` | Not a clip. |
| `Standard` | `2` | A possible clip. |
| `Featured` | `3` | A highlight, suggested as a clip. |

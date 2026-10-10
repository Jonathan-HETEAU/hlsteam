# steam.Timeline

**class** · package [`steam`](README.md) · source [`steam/Timeline.hx`](../../../../steam/Timeline.hx)

The Steam timeline of the game recordings (Steamworks `ISteamTimeline`): game modes, tooltips and events marking the important moments. Times are in seconds, relative to now.

## Static methods

### setTimelineTooltip

```haxe
static function setTimelineTooltip(description:String, timeDelta:Float):Void
```

Sets the description shown for the current state of the game in the timeline, from `timeDelta` seconds relative to now.

### clearTimelineTooltip

```haxe
static function clearTimelineTooltip(timeDelta:Float):Void
```

Clears the description set with `setTimelineTooltip`.

### setTimelineGameMode

```haxe
static function setTimelineGameMode(mode:ETimelineGameMode):Void
```

Sets the mode of the game, shown with colors in the timeline.

### addInstantaneousTimelineEvent

```haxe
static function addInstantaneousTimelineEvent(title:String, description:String, icon:String, priority:Int, startOffsetSeconds:Float, ?possibleClip:ETimelineEventClipPriority = None):TimelineEventHandle
```

Adds an event at a moment: `icon` is a Steam icon name (`steam_` icons or icons uploaded for the game), `priority` sorts the overlapping events (`0` to `1000`), and `startOffsetSeconds` is relative to now.

### addRangeTimelineEvent

```haxe
static function addRangeTimelineEvent(title:String, description:String, icon:String, priority:Int, startOffsetSeconds:Float, durationSeconds:Float, ?possibleClip:ETimelineEventClipPriority = None):TimelineEventHandle
```

Adds an event lasting `durationSeconds` (see `addInstantaneousTimelineEvent`).

### startRangeTimelineEvent

```haxe
static function startRangeTimelineEvent(title:String, description:String, icon:String, priority:Int, startOffsetSeconds:Float, ?possibleClip:ETimelineEventClipPriority = None):TimelineEventHandle
```

Starts an event whose end is not known yet: end it with `endRangeTimelineEvent`.

### updateRangeTimelineEvent

```haxe
static function updateRangeTimelineEvent(event:TimelineEventHandle, title:String, description:String, icon:String, priority:Int, ?possibleClip:ETimelineEventClipPriority = None):Void
```

Changes the information of an event started with `startRangeTimelineEvent`.

### endRangeTimelineEvent

```haxe
static function endRangeTimelineEvent(event:TimelineEventHandle, endOffsetSeconds:Float):Void
```

Ends an event started with `startRangeTimelineEvent`, `endOffsetSeconds` relative to now.

### removeTimelineEvent

```haxe
static function removeTimelineEvent(event:TimelineEventHandle):Void
```

Removes an event.

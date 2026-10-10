package steam;

/**
	The mode of the game shown in the Steam timeline (Steamworks `ETimelineGameMode`).
**/
enum abstract ETimelineGameMode(Int) from Int to Int {
	/**
		Invalid.
	**/
	var Invalid = 0;
	/**
		The player is playing.
	**/
	var Playing = 1;
	/**
		The player is preparing (lobby, character creation...).
	**/
	var Staging = 2;
	/**
		The player is in the menus.
	**/
	var Menus = 3;
	/**
		The game is loading.
	**/
	var LoadingScreen = 4;
}

/**
	Whether a timeline event is a good candidate for a clip (Steamworks `ETimelineEventClipPriority`).
**/
enum abstract ETimelineEventClipPriority(Int) from Int to Int {
	/**
		Invalid.
	**/
	var Invalid = 0;
	/**
		Not a clip.
	**/
	var None = 1;
	/**
		A possible clip.
	**/
	var Standard = 2;
	/**
		A highlight, suggested as a clip.
	**/
	var Featured = 3;
}

/**
	A handle of a timeline event.
**/
typedef TimelineEventHandle = hl.I64;

/**
	The Steam timeline of the game recordings (Steamworks `ISteamTimeline`): game modes, tooltips and events marking the important moments. Times are in seconds, relative to now.
**/
@:access(steam.TimelineNative)
class Timeline {
	/**
		Sets the description shown for the current state of the game in the timeline, from `timeDelta` seconds relative to now.
	**/
	public static function setTimelineTooltip(description:String, timeDelta:Float):Void {
		@:privateAccess TimelineNative.setTimelineTooltip(description.toUtf8(), timeDelta);
	}

	/**
		Clears the description set with `setTimelineTooltip`.
	**/
	public static function clearTimelineTooltip(timeDelta:Float):Void {
		TimelineNative.clearTimelineTooltip(timeDelta);
	}

	/**
		Sets the mode of the game, shown with colors in the timeline.
	**/
	public static function setTimelineGameMode(mode:ETimelineGameMode):Void {
		TimelineNative.setTimelineGameMode(mode);
	}

	/**
		Adds an event at a moment: `icon` is a Steam icon name (`steam_` icons or icons uploaded for the game), `priority` sorts the overlapping events (`0` to `1000`), and `startOffsetSeconds` is relative to now.
	**/
	public static function addInstantaneousTimelineEvent(title:String, description:String, icon:String, priority:Int, startOffsetSeconds:Float, possibleClip:ETimelineEventClipPriority = None):TimelineEventHandle {
		return @:privateAccess TimelineNative.addInstantaneousTimelineEvent(title.toUtf8(), description.toUtf8(), icon.toUtf8(), priority, startOffsetSeconds, possibleClip);
	}

	/**
		Adds an event lasting `durationSeconds` (see `addInstantaneousTimelineEvent`).
	**/
	public static function addRangeTimelineEvent(title:String, description:String, icon:String, priority:Int, startOffsetSeconds:Float, durationSeconds:Float, possibleClip:ETimelineEventClipPriority = None):TimelineEventHandle {
		return @:privateAccess TimelineNative.addRangeTimelineEvent(title.toUtf8(), description.toUtf8(), icon.toUtf8(), priority, startOffsetSeconds, durationSeconds, possibleClip);
	}

	/**
		Starts an event whose end is not known yet: end it with `endRangeTimelineEvent`.
	**/
	public static function startRangeTimelineEvent(title:String, description:String, icon:String, priority:Int, startOffsetSeconds:Float, possibleClip:ETimelineEventClipPriority = None):TimelineEventHandle {
		return @:privateAccess TimelineNative.startRangeTimelineEvent(title.toUtf8(), description.toUtf8(), icon.toUtf8(), priority, startOffsetSeconds, possibleClip);
	}

	/**
		Changes the information of an event started with `startRangeTimelineEvent`.
	**/
	public static function updateRangeTimelineEvent(event:TimelineEventHandle, title:String, description:String, icon:String, priority:Int, possibleClip:ETimelineEventClipPriority = None):Void {
		@:privateAccess TimelineNative.updateRangeTimelineEvent(event, title.toUtf8(), description.toUtf8(), icon.toUtf8(), priority, possibleClip);
	}

	/**
		Ends an event started with `startRangeTimelineEvent`, `endOffsetSeconds` relative to now.
	**/
	public static function endRangeTimelineEvent(event:TimelineEventHandle, endOffsetSeconds:Float):Void {
		TimelineNative.endRangeTimelineEvent(event, endOffsetSeconds);
	}

	/**
		Removes an event.
	**/
	public static function removeTimelineEvent(event:TimelineEventHandle):Void {
		TimelineNative.removeTimelineEvent(event);
	}
}

/**
	The native functions of `Timeline`.
**/
@:hlNative("steam")
class TimelineNative {
	static function setTimelineTooltip(description:hl.Bytes, timeDelta:hl.F32):Void {}
	static function clearTimelineTooltip(timeDelta:hl.F32):Void {}
	static function setTimelineGameMode(mode:Int):Void {}

	static function addInstantaneousTimelineEvent(title:hl.Bytes, description:hl.Bytes, icon:hl.Bytes, priority:Int, startOffsetSeconds:hl.F32, possibleClip:Int):hl.I64 { return 0; }
	static function addRangeTimelineEvent(title:hl.Bytes, description:hl.Bytes, icon:hl.Bytes, priority:Int, startOffsetSeconds:hl.F32, durationSeconds:hl.F32, possibleClip:Int):hl.I64 { return 0; }

	static function startRangeTimelineEvent(title:hl.Bytes, description:hl.Bytes, icon:hl.Bytes, priority:Int, startOffsetSeconds:hl.F32, possibleClip:Int):hl.I64 { return 0; }
	static function updateRangeTimelineEvent(event:hl.I64, title:hl.Bytes, description:hl.Bytes, icon:hl.Bytes, priority:Int, possibleClip:Int):Void {}
	static function endRangeTimelineEvent(event:hl.I64, endOffsetSeconds:hl.F32):Void {}
	static function removeTimelineEvent(event:hl.I64):Void {}
}

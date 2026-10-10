# steam.LeaderboardScore

**class** · package [`steam`](README.md) · module `steam.Api` · source [`steam/Api.hx`](../../../../steam/Api.hx)

A leaderboard score.

## Constructor

### new

```haxe
function new(leaderboardId_:String, score_:Int, detail_:Int, ?rank_:Int = -1):Void
```

Creates a score.

## Static methods

### fromString

```haxe
static function fromString(str:String):LeaderboardScore
```

Parses a score written by `toString`, or returns `null`.

## Variables

### leaderboardId

```haxe
var leaderboardId:String
```

The name of the leaderboard.

### score

```haxe
var score:Int
```

The score.

### detail

```haxe
var detail:Int
```

Additional data stored with the score.

### rank

```haxe
var rank:Int
```

The global rank, or `-1` if unknown.

## Methods

### toString

```haxe
function toString():String
```

Returns the score as `leaderboardId,score,detail,rank`.

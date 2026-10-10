# steam.LobbyListFilters

**typedef** · package [`steam`](README.md) · module `steam.Matchmaking` · source [`steam/Matchmaking.hx`](../../../../steam/Matchmaking.hx)

The filters of `Matchmaking.requestLobbyList`.

## Fields

### stringFilters

```haxe
var ?stringFilters:Null<Array<{ value:String, key:String, comparison:ComparisonFilter }>>
```

Filters on string lobby data.

### nearFilters

```haxe
var ?nearFilters:Null<Array<{ value:Int, key:String }>>
```

Sorts the lobbies by the distance of the numerical data to the value.

### intFilters

```haxe
var ?intFilters:Null<Array<{ value:Int, key:String, comparison:ComparisonFilter }>>
```

Filters on numerical lobby data.

### distance

```haxe
var ?distance:Null<DistanceFilter>
```

The geographic distance.

### availableSlots

```haxe
var ?availableSlots:Null<Int>
```

The minimum number of free slots.

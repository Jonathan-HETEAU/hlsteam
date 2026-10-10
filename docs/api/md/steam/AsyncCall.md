# steam.AsyncCall

**abstract** · package [`steam`](README.md) · source [`steam/AsyncCall.hx`](../../../../steam/AsyncCall.hx)

A pending asynchronous Steam call: its callback is called when it completes, unless it is cancelled.

Underlying type: `steam._AsyncCall.AsyncData`

## Methods

### cancel

```haxe
inline function cancel():Void
```

Cancels the call: its callback won't be called.

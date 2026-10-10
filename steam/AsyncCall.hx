package steam;

private typedef AsyncData = hl.Abstract<"steam_call_result">;

/**
	A pending asynchronous Steam call: its callback is called when it completes, unless it is cancelled.
**/
@:hlNative("steam")
abstract AsyncCall(AsyncData) {

	/**
		Cancels the call: its callback won't be called.
	**/
	public inline function cancel() {
		if( this != null ) {
			cancelCallResult(this);
			this = null;
		}
	}

	static function cancelCallResult( a : AsyncData ) {
	}

}

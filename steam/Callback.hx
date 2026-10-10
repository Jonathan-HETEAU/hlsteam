package steam;

/**
	The callback of an asynchronous Steam call: the result, and `true` if the call failed.
**/
typedef Callback<T> = T -> Bool -> Void;


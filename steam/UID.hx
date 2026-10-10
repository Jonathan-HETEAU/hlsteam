package steam;

/**
	A 64 bits Steam identifier (`CSteamID`: user, lobby, game server...) or Workshop file identifier, stored as 8 bytes.
**/
abstract UID(hl.Bytes) {
	function new(uid) {
		this = uid;
	}
	/**
		Returns the identifier in hexadecimal.
	**/
	public function toString() {
		return this == null ? "NULL" : getBytes().toHex();
	}
	/**
		Returns the 8 bytes of the identifier.
	**/
	public function getBytes() {
		return this.toBytes(8);
	}
	/**
		Returns the identifier as a 64 bits integer.
	**/
	public function getInt64() : haxe.Int64 {
		return haxe.Int64.make(this.getI32(4), this.getI32(0));
	}
	@:op(a == b) static function __compare( a : UID, b : UID ) {
		return (cast a : hl.Bytes).compare(0, (cast b : hl.Bytes), 0, 8) == 0;
	}
	/**
		Returns the identifier from its 8 bytes. Throws if the length is not 8.
	**/
	public static function fromBytes( bytes : haxe.io.Bytes ) : UID {
		if( bytes.length != 8 ) throw "Invalid UID";
		return new UID(@:privateAccess bytes.b);
	}
	/**
		Returns the identifier from a 64 bits integer.
	**/
	public static function fromInt64( v:haxe.Int64 ) {
		var b = new hl.Bytes(8);
		b.setI32(0, v.low);
		b.setI32(4, v.high);
		return new UID(b);
	}
}
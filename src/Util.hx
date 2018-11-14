class Util {
	public static function mod(a:Int, b:Int) {
		var r = a % b;
		return r < 0 ? r + b : r;
	}
}

class ERegUtil {
	public static function matchedInt(reg:EReg, n:Int):Null<Int> {
		return Std.parseInt(reg.matched(n));
	}
}

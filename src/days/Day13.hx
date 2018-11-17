package days;

class Day13 {
	public static function isWall(x:Int, y:Int, favoriteNumber:Int):Bool {
		var n = x * x + 3 * x + 2 * x * y + y + y * y; 
		n += favoriteNumber;
		return countBinaryOnes(n) % 2 != 0;
	}

	public static function countBinaryOnes(n:Int):Int {
		var ones = 0;
		while (n > 0) {
			if (n % 2 != 0) {
				ones++;
			}
			n = Std.int(n / 2);
		}
		return ones;
	}
}

package days;

class Day19 {
	public static function getWinner(elves:Int):Int {
		var biggestN = 0;
		while (true) {
			var nextPower = Math.pow(2, biggestN);
			if (nextPower > elves) {
				break;
			}
			biggestN++;
		}
		var biggestPowerOfTwo = Std.int(Math.pow(2, biggestN - 1));
		return (elves - biggestPowerOfTwo) * 2 + 1;
	}
}

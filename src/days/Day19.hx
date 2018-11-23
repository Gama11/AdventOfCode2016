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

	public static function getWinner2(elves:Int):Int {
		var list = [for (i in 0...elves) i + 1];
		var i = 0;
		while (list.length > 1) {
			var next = (i + Math.floor(list.length / 2)) % list.length;
			list.splice(next, 1);
			if (next < i) {
				i--;
			}
			i = (i + 1) % list.length;
		}
		return list[0];
	}
}

class Day2 {
	public static function getCode(instructions:String):String {
		var keypad = [
			[1, 2, 3],
			[4, 5, 6],
			[7, 8, 9]
		];
		var pos = {x: 1, y: 1};
		var digits = [];

		for (line in instructions.split("\n")) {
			for (i in 0...line.length) {
				switch (line.charAt(i)) {
					case "U": pos.y--;
					case "D": pos.y++;
					case "L": pos.x--;
					case "R": pos.x++; 
				}
				pos.x = bound(pos.x, 0, 2);
				pos.y = bound(pos.y, 0, 2);
			}
			digits.push(keypad[pos.y][pos.x]);
		}

		return digits.join("");
	}

	static function bound(i:Int, lower:Int, upper:Int):Int {
		if (i < lower) {
			return lower;
		} else if (i > upper) {
			return upper;
		}
		return i;
	}
}

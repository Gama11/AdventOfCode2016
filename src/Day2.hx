class Day2 {
	public static function getTestCode(instructions:String):String {
		var keypad = [
			["1", "2", "3"],
			["4", "5", "6"],
			["7", "8", "9"]
		];
		return getCode(keypad, {x: 1, y: 1}, instructions);
	}

	public static function getActualCode(instructions:String):String {
		var keypad = [
			[null, null, "1", null, null],
			[null, "2",  "3", "4",  null],
			["5",  "6",  "7", "8",  "9" ],
			[null, "A",  "B", "C",  null],
			[null, null, "D", null, null],
		];
		return getCode(keypad, {x: 0, y: 2}, instructions);
	}

	static function getCode(keypad:Array<Array<String>>, startPos:{x:Int, y:Int}, instructions:String):String {
		var pos = startPos;
		var digits = [];

		function getDigit(pos) {
			var row = keypad[pos.y];
			if (row == null) {
				return null;
			}
			return row[pos.x];
		}

		for (line in instructions.split("\n")) {
			for (i in 0...line.length) {
				var newPos = {x: pos.x, y: pos.y};
				switch (line.charAt(i)) {
					case "U": newPos.y--;
					case "D": newPos.y++;
					case "L": newPos.x--;
					case "R": newPos.x++; 
				}
				if (getDigit(newPos) != null) {
					pos = newPos;
				}
			}
			digits.push(getDigit(pos));
		}

		return digits.join("");
	}
}

class Day4 {
	public static function checkRoom(room:String):Room {
		room = room.replace("-", "");
		var regex = ~/([a-z]+)([0-9]+)\[([a-z]+)\]/;
		if (!regex.match(room)) {
			throw "regex failure: " + room;
		}
		var name = regex.matched(1);
		var id = Std.parseInt(regex.matched(2));
		var checksum = regex.matched(3);

		var actualChecksum = sortLettersByCount(countLetters(name)).join("").substr(0, 5);
		if (checksum == actualChecksum) {
			return Real(id);
		}
		return Decoy;
	}

	static function countLetters(s:String):Map<String, Int> {
		var letterCounts = new Map<String, Int>();
		for (i in 0...s.length) {
			var letter = s.charAt(i);
			var count = letterCounts[letter];
			if (count == null) {
				count = 0;
			}
			letterCounts[letter] = count + 1;
		}
		return letterCounts;
	}

	static function sortLettersByCount(letterCounts:Map<String, Int>):Array<String> {
		var letters = [for (letter in letterCounts.keys()) letter];
		letters.sort((a, b) -> {
			var countA = letterCounts[a];
			var countB = letterCounts[b];
			if (countA == countB) {
				return Reflect.compare(a, b);
			}
			return countB - countA;
		});
		return letters;
	}

	public static function sumRealRoomIDs(input:String):Int {
		return input.split("\n").map(line -> switch (checkRoom(line)) {
			case Real(id): id;
			case Decoy: 0;
		}).fold((a, b) -> a + b, 0);
	}
}

enum Room {
	Real(id:Int);
	Decoy;
}

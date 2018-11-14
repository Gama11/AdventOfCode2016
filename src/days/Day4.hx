package days;

class Day4 {
	static function parse(input:String):Room {
		var regex = ~/([a-z\-]+)-([0-9]+)(?:\[([a-z]+)\])?/;
		if (!regex.match(input)) {
			throw "regex failure: " + input;
		}
		return {
			name: regex.matched(1),
			id: Std.parseInt(regex.matched(2)),
			checksum: regex.matched(3)
		};
	}
	
	public static function checkRoom(input:String):RoomStatus {
		var room = parse(input);
		var name = room.name.replace("-", "");
		var actualChecksum = sortLettersByCount(countLetters(name)).join("").substr(0, 5);
		if (room.checksum == actualChecksum) {
			return Real(room.id);
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

	public static function decrypt(input:String):Room {
		var room = parse(input);
		var name = "";
		for (i in 0...room.name.length) {
			var letter = room.name.charAt(i);
			if (letter != "-") {
				final asciiOffset = 97;
				var code = letter.charCodeAt(0) - asciiOffset;
				code = (code + room.id) % 26;
				name += String.fromCharCode(code + asciiOffset);
			} else {
				name += " ";
			}
		}
		room.name = name;
		return room;
	}

	public static function findIDforName(input:String, name:String):Int {
		return input.split("\n").map(Day4.decrypt).find(room -> room.name == name).id;
	}
}

typedef Room = {
	var name:String;
	var id:Int;
	var checksum:String;
}

enum RoomStatus {
	Real(id:Int);
	Decoy;
}

package days;

import haxe.crypto.Md5;

class Day14 {
	public static function characterInRow(s:String, times:Int):Null<String> {
		var count = 1;
		var prev = null;
		for (i in 0...s.length) {
			var char = s.charAt(i);
			if (char == prev) {
				count++;
			} else {
				count = 1;
			}
			if (count >= times) {
				return char;
			}
			prev = char;
		}
		return null;
	}

	public static function get64thKeyIndex(salt:String, stretch:Int = 0) {
		var validKeys = [];
		var candidates = new Map<String, Array<Int>>();
		var i = 0;
		while (validKeys.length < 70) {
			var key = Md5.encode(salt + i);
			for (_ in 0...stretch) {
				key = Md5.encode(key);
			}
			var five = characterInRow(key, 5);
			if (five != null) {
				var candidatesForChar = candidates[five];
				if (candidatesForChar != null) {
					candidates.remove(five);
					for (candidate in candidatesForChar) {
						if (i - candidate <= 1000) {
							validKeys.push(candidate);
						}
					}
				}
			}
			var triplet = characterInRow(key, 3);
			if (triplet != null) {
				var candidatesForChar = candidates[triplet];
				if (candidatesForChar == null) {
					candidatesForChar = [];
				}
				candidatesForChar.push(i);
				candidates[triplet] = candidatesForChar;
			}
			i++;
		}
		validKeys.sort(Reflect.compare);
		return validKeys[63];
	}
}

package days;

import haxe.crypto.Md5;

class Day5 {
	public static function findPassword(doorID:String) {
		var i = 0;
		var password = "";
		while (password.length < 8) {
			var hash = Md5.encode(doorID + i);
			if (hash.startsWith("00000")) {
				password += hash.charAt(5);
			}
			i++;
		}
		return password;
	}

	public static function findPassword2(doorID:String) {
		var i = 0;
		var filled = 0;
		var password = [];
		while (filled < 8) {
			var hash = Md5.encode(doorID + i);
			if (hash.startsWith("00000")) {
				var index = Std.parseInt(hash.charAt(5));
				if (index != null && password[index] == null && index <= 7) {
					password[index] = hash.charAt(6);
					filled++;
				}
			}
			i++;
		}
		return password.join("");
	}
}

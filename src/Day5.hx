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
}

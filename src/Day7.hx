class Day7 {
	static function hasABBA(s:String):Bool {
		var i = 0;
		while (i + 3 < s.length) {
			var a = s.charAt(i);
			var b = s.charAt(i + 1);
			var c = s.charAt(i + 2);
			var d = s.charAt(i + 3);
			if (a == d && b == c && a != b) {
				return true;
			}
			i++;
		}
		return false;
	}

	public static function supportsTLS(ip:String):Bool {
		var regex = ~/([a-z]+)\[([a-z]+)\]([a-z]+)/;
		if (!regex.match(ip)) {
			throw "no match " + ip;
		}
		if (hasABBA(regex.matched(2))) {
			return false;
		}
		return hasABBA(regex.matched(1)) || hasABBA(regex.matched(3));
	}

	public static function countIPsWithTLS(ips:String):Int {
		return ips.split("\n").filter(supportsTLS).length;
	}
}

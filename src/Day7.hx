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
		var insides = [];
		var outsides = [];
		var inside = false;
		var buffer = "";

		function push() {
			if (buffer.length > 0) {
				(if (inside) insides else outsides).push(buffer);
				buffer = "";
			}
		}
		for (i in 0...ip.length) {
			switch (ip.charAt(i)) {
				case '[':
					push();
					inside = true;
				case ']':
					push();
					inside = false;
				case c:
					buffer += c;
			}
		}
		push();

		return outsides.exists(hasABBA) && !insides.exists(hasABBA);
	}

	public static function countIPsWithTLS(ips:String):Int {
		return ips.split("\n").filter(supportsTLS).length;
	}
}

class Day7 {
	static function hasPattern(s:String, pattern:String):Bool {
		var i = 0;
		while (i + pattern.length - 1 < s.length) {
			var valid = true;
			var bindings = new Map<String, String>();
			for (j in 0...pattern.length) {
				var ident = pattern.charAt(j);
				var char = s.charAt(i + j);
				var binding = bindings[ident];
				if (binding == null) {
					for (existing in bindings) {
						if (existing == char) {
							valid = false;
							break;
						}
					}
					bindings[ident] = char;
				} else if (binding != char) {
					valid = false;
					break;
				}
			}
			if (valid) {
				return true;
			}
			i++;
		}
		return false;
	}

	public static function supportsTLS(ip:String):Bool {
		var ip = parseIP(ip);
		var hasABBA = hasPattern.bind(_, "abba");
		return ip.outsides.exists(hasABBA) && !ip.insides.exists(hasABBA);
	}

	static function parseIP(ip):IP {
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

		return {insides: insides, outsides: outsides};
	}

	public static function countIPsWithTLS(ips:String):Int {
		return ips.split("\n").filter(supportsTLS).length;
	}
}

typedef IP = {
	final insides:Array<String>;
	final outsides:Array<String>;
}

class Day7 {
	static function matchPattern(s:String, pattern:String):Null<Array<Map<String, String>>> {
		var i = 0;
		var bindingsList = null;
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
				if (bindingsList == null) {
					bindingsList = [];
				}
				bindingsList.push(bindings);
			}
			i++;
		}
		return bindingsList;
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

	public static function supportsTLS(ip:String):Bool {
		var ip = parseIP(ip);
		var hasABBA = ip -> matchPattern(ip, "abba") != null;
		return ip.outsides.exists(hasABBA) && !ip.insides.exists(hasABBA);
	}

	public static function supportsSSL(ip:String):Bool {
		var ip = parseIP(ip);
		function findBinding(list:Array<String>, pattern:String) {
			for (sequence in list) {
				var bindings = matchPattern(sequence, pattern);
				if (bindings != null) {
					return bindings;
				}
			}
			return null;
		}
		var outsideBindingsList = findBinding(ip.outsides, "aba");
		var insideBindingsList = findBinding(ip.insides, "bab");
		if (outsideBindingsList == null || insideBindingsList == null) {
			return false;
		}
		for (outsideBindings in outsideBindingsList) {
			for (insideBindings in insideBindingsList) {
				var valid = true;
				for (key in outsideBindings.keys()) {
					if (outsideBindings[key] != insideBindings[key]) {
						valid = false;
						break;
					}
				}
				if (valid) {
					return true;
				}
			}
		}
		return false;
	}

	public static function count(ips:String, supports:String->Bool):Int {
		return ips.split("\n").filter(supports).length;
	}
}

typedef IP = {
	final insides:Array<String>;
	final outsides:Array<String>;
}

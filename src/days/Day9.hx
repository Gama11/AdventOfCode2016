package days;

class Day9 {
	public static function decompress(input:String, recurse:Bool):Float {
		var regex = ~/^\(([0-9]+)x([0-9]+)\)/;
		var i = 0;
		var result = 0.0;
		while (i < input.length) {
			var c = input.charAt(i);
			if (c == "(") {
				var substr = input.substr(i);
				if (!regex.match(input.substr(i))) {
					throw "no match on " + substr;
				}
				var instruction = regex.matched(0);
				i += instruction.length;

				var length = regex.matchedInt(1);
				var amount = regex.matchedInt(2);
				var section = input.substr(i, length);

				result += amount * if (recurse) {
					decompress(section, true);
				} else {
					length;
				}
				i += length;
				
			} else {
				result++;
				i++;
			}
		}
		return result;
	}
}

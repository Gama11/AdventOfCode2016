class Day9 {
	public static function decompress(input:String):String {
		var regex = ~/^\(([0-9]+)x([0-9]+)\)/;
		var output = "";
		var i = 0;
		while (i < input.length) {
			var c = input.charAt(i);
			if (c == "(") {
				var substr = input.substr(i);
				if (!regex.match(input.substr(i))) {
					throw "no match on " + substr;
				}
				var instruction = regex.matched(0);
				i += instruction.length;

				var length = Std.parseInt(regex.matched(1));
				var amount = Std.parseInt(regex.matched(2));
				var section = input.substr(i, length);
				for (j in 0...amount) {
					output += section;
				}
				i += length;
			} else {
				output += c;
				i++;
			}
		}
		return output;
	}
}
package days;

class Day16 {
	public static function generateData(a:String):String {
		var buffer = new StringBuf();
		buffer.add(a);
		buffer.add("0");
		var i = a.length;
		while (i-- > 0) {
			buffer.add(switch (a.charAt(i)) {
				case "0": "1";
				case "1": "0";
				case _: throw "invalid char";
			});
		}
		return buffer.toString();
	}
}

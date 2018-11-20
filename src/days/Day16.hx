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

	public static function calculateChecksum(data:String):String {
		var buffer = new StringBuf();
		for (i in 0...Std.int(data.length / 2)) {
			var c1 = data.charAt(i * 2);
			var c2 = data.charAt(i * 2 + 1);
			buffer.add(if (c1 == c2) "1" else "0");
		}
		var checksum = buffer.toString();
		if (checksum.length % 2 == 0) {
			checksum = calculateChecksum(checksum);
		}
		return checksum;
	}

	public static function fillDisk(a:String, length:Int):String {
		var data = a;
		while (data.length < length) {
			data = generateData(data);
		}
		data = data.substr(0, length);
		return calculateChecksum(data);
	}
}

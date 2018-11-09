class Day3 {
	public static function isPossibleTriangle(input:String):Bool {
		var sideLengths = ~/ +/g.split(input.trim()).map(Std.parseInt);
		sideLengths.sort((a, b) -> a - b);
		var a = sideLengths[0];
		var b = sideLengths[1];
		var c = sideLengths[2];
		return a + b > c;
	}

	public static function countPossibleTriangles(input:String):Int {
		return input.split("\n").filter(isPossibleTriangle).length;
	}
}

typedef Triangle = {
	var a:Int;
	var b:Int;
	var c:Int;
}

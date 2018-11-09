class Day3 {
	public static function isPossibleTriangle(a:Int, b:Int, c:Int):Bool {
		var sides = [a, b, c];
		sides.sort((a, b) -> a - b);
		var a = sides[0];
		var b = sides[1];
		var c = sides[2];
		return a + b > c;
	}

	public static function countPossibleTrianglesByRow(input:String):Int {
		return parse(input).filter(row -> isPossibleTriangle(row[0], row[1], row[2])).length;
	}

	public static function countPossibleTrianglesByColumn(input:String):Int {
		return 0;
	}

	static function parse(input:String):Array<Array<Null<Int>>> {
		return input.split("\n").map(row -> ~/ +/g.split(row.trim()).map(Std.parseInt));
	}
}

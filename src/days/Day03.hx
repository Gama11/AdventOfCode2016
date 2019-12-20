package days;

class Day03 {
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
		var count = 0;
		var grid = parse(input);
		var i = 0;
		while (i < grid.length) {
			var row1 = grid[i];
			var row2 = grid[i + 1];
			var row3 = grid[i + 2];

			function countColumn(i:Int) {
				if (isPossibleTriangle(row1[i], row2[i], row3[i])) {
					count++;
				}
			}
			countColumn(0);
			countColumn(1);
			countColumn(2);

			i += 3;
		}
		return count;
	}

	static function parse(input:String):Array<Array<Null<Int>>> {
		return input.split("\n").map(row -> ~/ +/g.split(row.trim()).map(Std.parseInt));
	}
}

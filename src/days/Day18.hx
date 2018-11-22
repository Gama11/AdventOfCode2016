package days;

class Day18 {
	public static function countSafeTiles(firstRow:String, rows:Int):Int {
		var previousRow:Array<Tile> = firstRow.split("");
		function countSafeTilesInRow(row:Array<Tile>) {
			return row.filter(tile -> tile == Safe).length;
		}
		var safeTiles = countSafeTilesInRow(previousRow);
		for (_ in 1...rows) {
			var newRow = [];
			for (i in 0...previousRow.length) {
				inline function getTile(i:Int) {
					var tile = previousRow[i];
					return if (tile == null) Safe else tile;
				}
				var left = getTile(i - 1);
				var center = getTile(i);
				var right = getTile(i + 1);
				newRow.push(switch [left, center, right] {
					case [Trap, Trap, Safe] |
						 [Safe, Trap, Trap] |
						 [Trap, Safe, Safe] |
						 [Safe, Safe, Trap]: Trap;
					case _: Safe;
				});
			}
			safeTiles += countSafeTilesInRow(newRow);
			previousRow = newRow;
		}
		return safeTiles;
	}
}

enum abstract Tile(String) from String {
	var Trap = "^";
	var Safe = ".";
}

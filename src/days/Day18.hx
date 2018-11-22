package days;

class Day18 {
	public static function countSafeTiles(firstRow:String):Int {
		var grid:Array<Array<Tile>> = [firstRow.split("")];
		while (grid.length < 40) {
			var previousRow = grid[grid.length - 1];
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
			grid.push(newRow);
		}
		return grid.flatten().filter(tile -> tile == Safe).length;
	}
}

enum abstract Tile(String) from String {
	var Trap = "^";
	var Safe = ".";
}

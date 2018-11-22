package days;

class Day18 {
	public static function countSafeTiles(firstRow:String):Int {
		var grid:Array<Array<Tile>> = [firstRow.split("")];
		while (grid.length < 40) {
			var previousRow = grid[grid.length - 1];
			var newRow = [];
			for (i in 0...previousRow.length) {
				var left = previousRow[i - 1];
				var center = previousRow[i];
				var right = previousRow[i + 1];
				var isTrap = (
					(left == Trap && center == Trap && right != Trap) ||
					(left != Trap && center == Trap && right == Trap) ||
					(left == Trap && center != Trap && right != Trap) ||
					(left != Trap && center != Trap && right == Trap));
				newRow.push(if (isTrap) Trap else Safe);
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

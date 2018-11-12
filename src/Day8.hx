class Day8 {
	static function createScreen(width:Int, height:Int):Screen {
		return [for (_ in 0...height) [for (_ in 0...width) false]];
	}

	static function parseOperations(input:String):Array<Operation> {
		var rectRegex = ~/rect ([0-9]+)x([0-9]+)/;
		var rotateRowRegex = ~/rotate row y=([0-9]+) by ([0-9]+)/;
		var rotateColumnRegex = ~/rotate column x=([0-9]+) by ([0-9]+)/;
		return input.split("\n").map(operation -> {
			return if (rectRegex.match(operation)) {
				Rect(
					Std.parseInt(rectRegex.matched(1)), 
					Std.parseInt(rectRegex.matched(2)));
			} else if (rotateRowRegex.match(operation)) {
				RotateRow(
					Std.parseInt(rotateRowRegex.matched(1)),
					Std.parseInt(rotateRowRegex.matched(2)));
			} else if (rotateColumnRegex.match(operation)) {
				RotateColumn(
					Std.parseInt(rotateColumnRegex.matched(1)),
					Std.parseInt(rotateColumnRegex.matched(2)));
			} else {
				throw 'invalid operation $operation';
			}
		});
	}

	static function executeOperation(screen:Screen, op:Operation) {
		switch (op) {
			case Rect(width, height):
				for (x in 0...width) {
					for (y in 0...height) {
						screen[y][x] = true;
					}
				}
			case RotateRow(y, by):
				var row = screen[y].copy();
				for (x in 0...row.length) {
					var newX = (x + by) % row.length;
					screen[y][newX] = row[x];
				}
			case RotateColumn(x, by):
				var column = [for (y in 0...screen.length) screen[y][x]];
				for (y in 0...column.length) {
					var newY = (y + by) % column.length;
					screen[newY][x] = column[y];
				}
		}
	}

	static function renderScreen(screen:Screen):String {
		return screen.map(row -> row.map(pixel -> if (pixel) "#" else ".").join("")).join("\n");
	}

	public static function visualize(width:Int, height:Int, ops:Array<Operation>) {
		var screen = createScreen(width, height);
		for (op in ops) {
			executeOperation(screen, op);
			Sys.println(renderScreen(screen) + "\n");
		}
	}
}

typedef Screen = Array<Array<Bool>>;

enum Operation {
	Rect(width:Int, height:Int);
	RotateRow(y:Int, by:Int);
	RotateColumn(x:Int, by:Int);
}

package days;

class Day8 {
	static function createScreen(width:Int, height:Int):Screen {
		return [for (_ in 0...height) [for (_ in 0...width) false]];
	}

	public static function parseOperations(input:String):Array<Operation> {
		var rectRegex = ~/rect ([0-9]+)x([0-9]+)/;
		var rotateRowRegex = ~/rotate row y=([0-9]+) by ([0-9]+)/;
		var rotateColumnRegex = ~/rotate column x=([0-9]+) by ([0-9]+)/;
		return input.split("\n").map(operation -> {
			return if (rectRegex.match(operation)) {
				Rect(
					rectRegex.matchedInt(1), 
					rectRegex.matchedInt(2));
			} else if (rotateRowRegex.match(operation)) {
				RotateRow(
					rotateRowRegex.matchedInt(1),
					rotateRowRegex.matchedInt(2));
			} else if (rotateColumnRegex.match(operation)) {
				RotateColumn(
					rotateColumnRegex.matchedInt(1),
					rotateColumnRegex.matchedInt(2));
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

	public static function determineLitPixelCount(width:Int, height:Int, input:String):Int {
		var screen = createScreen(width, height);
		for (op in parseOperations(input)) {
			executeOperation(screen, op);
		}
		return screen.flatten().filter(on -> on).length;
	}
}

typedef Screen = Array<Array<Bool>>;

enum Operation {
	Rect(width:Int, height:Int);
	RotateRow(y:Int, by:Int);
	RotateColumn(x:Int, by:Int);
}

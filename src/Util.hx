import polygonal.ds.Prioritizable;
import haxe.ds.HashMap;

class Util {
	public static function mod(a:Int, b:Int) {
		var r = a % b;
		return r < 0 ? r + b : r;
	}

	public static function findBounds(points:Array<Point>) {
		final n = 9999999;
		var maxX = -n;
		var maxY = -n;
		var minX = n;
		var minY = n;
		for (pos in points) {
			maxX = Std.int(Math.max(maxX, pos.x));
			maxY = Std.int(Math.max(maxY, pos.y));
			minX = Std.int(Math.min(minX, pos.x));
			minY = Std.int(Math.min(minY, pos.y));
		}
		return {
			min: new Point(minX, minY),
			max: new Point(maxX, maxY)
		};
	}

	public static function renderPointGrid(points:Array<Point>, render:Point->String, empty = " "):String {
		var bounds = findBounds(points);
		var min = bounds.min;
		var max = bounds.max;

		var grid = [for (_ in 0...max.y - min.y + 1) [for (_ in 0...max.x - min.x + 1) empty]];
		for (pos in points) {
			grid[pos.y - min.y][pos.x - min.x] = render(pos);
		}
		return grid.map(row -> row.join("")).join("\n") + "\n";
	}

	public static function renderPointHash<T>(map:HashMap<Point, T>, render:T->String, empty = " "):String {
		return renderPointGrid([for (p in map.keys()) p], p -> render(map.get(p)), empty);
	}
}

class StaticExtensions {
	public static function matchedInt(reg:EReg, n:Int):Null<Int> {
		return Std.parseInt(reg.matched(n));
	}

	public static function max<T>(a:Array<T>, f:T->Int) {
		var maxValue:Null<Int> = null;
		var list = [];
		for (e in a) {
			var value = f(e);
			if (maxValue == null || value > maxValue) {
				maxValue = value;
				list = [e];
			} else if (value == maxValue) {
				list.push(e);
			}
		}
		return {list: list, value: maxValue};
	}
}

class Point {
	public final x:Int;
	public final y:Int;

	public inline function new(x, y) {
		this.x = x;
		this.y = y;
	}

	public function hashCode():Int {
		return x + 10000 * y;
	}

	public inline function add(point:Point):Point {
		return new Point(x + point.x, y + point.y);
	}

	public function distanceTo(point:Point):Int {
		return Std.int(Math.abs(x - point.x) + Math.abs(y - point.y));
	}

	public inline function equals(point:Point):Bool {
		return x == point.x && y == point.y;
	}

	public function toString() {
		return '($x, $y)';
	}
}

class Movement {
	public static final Left = new Point(-1, 0);
	public static final Up = new Point(0, -1);
	public static final Down = new Point(0, 1);
	public static final Right = new Point(1, 0);
	public static final All = [Left, Up, Down, Right];
}

class PrioritizedItem<T> implements Prioritizable {
	public final item:T;
	public var priority(default, null):Float = 0;
	public var position(default, null):Int;

	public function new(item:T, priority:Float) {
		this.item = item;
		this.priority = priority;
	}
}

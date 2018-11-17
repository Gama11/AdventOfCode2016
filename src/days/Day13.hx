package days;

import Util.Movement;
import haxe.ds.HashMap;
import Util.Point;

class Day13 {
	public static function isWall(x:Int, y:Int, favoriteNumber:Int):Bool {
		var n = x * x + 3 * x + 2 * x * y + y + y * y; 
		n += favoriteNumber;
		return countBinaryOnes(n) % 2 != 0;
	}

	public static function countBinaryOnes(n:Int):Int {
		var ones = 0;
		while (n > 0) {
			if (n % 2 != 0) {
				ones++;
			}
			n = Std.int(n / 2);
		}
		return ones;
	}

	public static function findDistance(goal:Point, favoriteNumber:Int):Null<Int> {
		var start = new Point(1, 1);
		
		var map = new HashMap<Point, Bool>();
		var isWall = function(p:Point):Bool {
			if (map.get(p) == null) {
				map.set(p, isWall(p.x, p.y, favoriteNumber));
			}
			return map.get(p);
		}

		function getNeighbours(p:Point):Array<Point> {
			var neighbours = [];
			for (direction in Movement.All) {
				var neighbour = p.add(direction);
				if (p.x >= 0 && p.y >= 0 && !isWall(neighbour)) {
					neighbours.push(neighbour);
				}
			}
			return neighbours;
		}

		var closedSet = new HashMap<Point, Bool>();
		var openSet = [start];

		var nodes = new HashMap<Point, Node>();
		nodes.set(start, {
			gScore: 0,
			fScore: start.distanceTo(goal)
		});

		while (openSet.length > 0) {
			openSet.sort((p1, p2) -> nodes.get(p2).fScore - nodes.get(p1).fScore);
			var current = openSet.shift();
			if (current.equals(goal)) {
				return nodes.get(current).gScore;
			}

			closedSet.set(current, true);

			for (neighbour in getNeighbours(current)) {
				if (closedSet.exists(neighbour)) {
					continue;
				}
				if (!openSet.exists(p -> p.equals(neighbour))) {
					openSet.push(neighbour);
				}
				var tentativGScore = nodes.get(current).gScore + 1;
				var node = nodes.get(neighbour);
				if (node == null || node.gScore > tentativGScore) {
					nodes.set(neighbour, {
						gScore: tentativGScore,
						fScore: tentativGScore + neighbour.distanceTo(goal)
					});
				}
			}
		}

		return null;
	}
}

typedef Node = {
	var gScore:Int;
	var fScore:Int;
}

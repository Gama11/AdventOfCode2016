package days;

import Util.Point;
import haxe.ds.HashMap;

class Day22 {
	static function parseInput(input:String):Grid {
		var regex = ~/\/dev\/grid\/node-x(\d+)-y(\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T\s+(\d+)%/;
		var nodes = new HashMap();
		var maxX = 0;
		var maxY = 0;
		for (line in input.split("\n")) {
			if (regex.match(line)) {
				var x = regex.matchedInt(1);
				var y = regex.matchedInt(2);
				if (x > maxX) {
					maxX = x;
				}
				if (y > maxY) {
					maxY = y;
				}
				nodes.set(new Point(x, y), {
					size: regex.matchedInt(3),
					used: regex.matchedInt(4),
					available: regex.matchedInt(5)
				});
			}
		}
		return {
			maxX: maxX,
			maxY: maxY,
			nodes: nodes
		};
	}

	public static function countViablePairs(input:String):Int {
		var grid = parseInput(input);
		var count = 0;
		for (a in grid.nodes) {
			for (b in grid.nodes) {
				if (a == b) {
					continue;
				}
				if (a.used > 0 && a.used <= b.available) {
					count++;
				}
			}
		}
		return count;
	}

	public static function findMinimumDataAccessSteps(input:String):Int {
		var grid = parseInput(input);
		var highestAvailable = [for (node in grid.nodes) node.available].max(i -> i).value;
		Sys.println(Util.renderPointGrid([for (p in grid.nodes.keys()) p], function(p) {
			if (p.y == 0 && p.x == grid.maxX) {
				return "G";
			}
			var node = grid.nodes.get(p);
			if (node.used == 0) {
				return "_";
			}
			if (node.used > highestAvailable) {
				return "#";
			}
			return ".";
		}));

		// trivial to solve by hand from here, since:
		// - apart from a few nodes that can never be moved or moved to,
		//   the highest disk usage is lower than the minimum size (so a swap is always possible)
		// - there's only empty node that data can be moved to
		// => this effectively becomes a "sliding puzzle"
		var distanceBetweenEmptyAndGoal = 29;
		var stepsPerDataMove = 5;
		var distanceBetweenGoalAndOrigin = grid.maxX - 1;
		return distanceBetweenEmptyAndGoal + stepsPerDataMove * distanceBetweenGoalAndOrigin;
	}
}

private typedef Grid = {
	final maxX:Int;
	final maxY:Int;
	final nodes:HashMap<Point, Node>;
}

private typedef Node = {
	final size:Int;
	final used:Int;
	final available:Int;
}

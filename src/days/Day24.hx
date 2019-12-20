package days;

import haxe.ds.HashMap;
import Util.Movement;
import Util.Point;

class Day24 {
	public static function findShortestPath(input:String):Int {
		var grid = input.split("\n").map(line -> line.split(""));
		var maze = new HashMap<Point, Tile>();
		var locations = new Map<Location, Point>();
		var locationCount = 0;
		for (y in 0...grid.length) {
			var row = grid[y];
			for (x in 0...row.length) {
				var pos = new Point(x, y);
				var cell = row[x];
				if (cell != Wall && cell != Passage) {
					locations[cell] = pos;
					locationCount++;
				}
				maze.set(pos, cell);
			}
		}

		function findPath(from:Point, to:Point) {
			return AStar.search(new PruneState(from), s -> s.pos.equals(to), s -> s.pos.distanceTo(to), function(state) {
				var moves = [];
				for (dir in Movement.All) {
					var pos = state.pos.add(dir);
					var tile = maze.get(pos);
					if (tile == null || tile == Wall) {
						continue;
					}
					if (tile == Passage || locations[tile].equals(to)) {
						moves.push({
							cost: 1,
							state: new PruneState(pos)
						});
					}
				}
				return moves;
			});
		}
		var distances = [for (location in locations.keys()) location => new Map<Location, Int>()];
		for (a in locations.keys()) {
			for (b in locations.keys()) {
				if (a == b) {
					continue;
				}
				var path = findPath(locations[a], locations[b]);
				if (path != null) {
					distances[a][b] = path.score;
					distances[b][a] = path.score;
				}
			}
		}

		return AStar.search(new SearchState("0", []), s -> s.visitedCount() == locationCount, s -> locationCount - s.visitedCount(), function(state) {
			var moves = [];
			var targets = distances[state.location];
			for (target in targets.keys()) {
				moves.push({
					cost: targets[target],
					state: new SearchState(target, state.visited.copy())
				});
			}
			return moves;
		}).score;
	}
}

private enum abstract Tile(String) from String to String {
	var Wall = "#";
	var Passage = ".";
}

private typedef Location = String;

private class PruneState {
	public final pos:Point;

	public function new(pos) {
		this.pos = pos;
	}

	public function hashCode():String {
		return pos.toString();
	}
}

private class SearchState {
	public final location:Location;
	public final visited:Map<Location, Bool>;

	public function new(location, visited) {
		this.location = location;
		this.visited = visited;
		visited[location] = true;
	}

	public function visitedCount():Int {
		return [for (_ in visited) _].length;
	}

	public function hashCode() {
		return location + " " + visited;
	}
}

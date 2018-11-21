package days;

import haxe.crypto.Md5;
import Util.Movement.*;
import Util.Point;

class Day17 {
	public static function findShortestPath(passcode:String):String {
		var goal = new Point(3, 3);
		function explore(position:Point, path:String):String {
			if (position.equals(goal)) {
				return path;
			}
			var moves = getPossibleMoves(position, passcode + path);
			var shortestPath:String = null;
			for (move in moves) {
				var newPosition = position.add(move);
				var newPath = path + switch (move) {
					case Up: "U";
					case Down: "D";
					case Left: "L";
					case Right: "R";
				}
				var pathForMove = explore(newPosition, newPath);
				if (pathForMove != null) {
					if (shortestPath == null || shortestPath.length > pathForMove.length) {
						shortestPath = pathForMove;
					}
				}
			}
			return shortestPath;
		}
		return explore(new Point(0, 0), "");
	}

	static function getPossibleMoves(position:Point, input:String):Array<Point> {
		var possibleMoves = [];
		var hash = Md5.encode(input);
		var moves = [Up, Down, Left, Right];
		for (i in 0...moves.length) {
			var move = moves[i];
			var c = hash.charAt(i);
			if (c != "b" && c != "c" && c != "d" && c != "e" && c != "f") {
				// door is closed
				continue;
			}
			var neighbour = position.add(move);
			if (neighbour.x < 0 || neighbour.x > 3 || neighbour.y < 0 || neighbour.y > 3) {
				// outside the 4x4 grid
				continue;
			}
			possibleMoves.push(move);
		}
		return possibleMoves;
	}
}

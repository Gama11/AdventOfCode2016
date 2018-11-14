package days;

using Lambda;

class Day1 {
	static function parseSequence(sequence:String):Array<Instruction> {
		return sequence.split(", ").map(s -> {
			var direction = s.charAt(0);
			var steps = Std.parseInt(s.substr(1));
			var turn = switch (direction) {
				case "L": Left;
				case "R": Right;
				case _: throw 'unknown turn direction $direction';
			}
			return {turn: turn, steps: steps};
		});
	}

	static function getLength(x:Int, y:Int):Int {
		return Std.int(Math.abs(x) + Math.abs(y));
	}

	public static function getDistanceToHQ(sequence:String):Int {
		var finalX = 0;
		var finalY = 0;
		walk(sequence, (x, y) -> {
			finalX = x;
			finalY = y;
			return true;
		});
		return getLength(finalX, finalY);
	}

	public static function getDistanceToFirstVisitedTwice(sequence:String):Int {
		var finalX = 0;
		var finalY = 0;
		var previousLocations = [];
		walk(sequence, function(x:Int, y:Int) {
			finalX = x;
			finalY = y;
			var visitedBefore = previousLocations.exists(p -> p.x == x && p.y == y);
			if (visitedBefore) {
				return false;
			}
			previousLocations.push({x: x, y: y});
			return true;
		});
		return getLength(finalX, finalY);
	}

	static function walk(sequence:String, proceed:(x:Int, y:Int) -> Bool) {
		var instructions = parseSequence(sequence);
		var x = 0;
		var y = 0;
		var directionIndex = 0;
		var directions = [North, East, South, West];

		for (instruction in instructions) {
			directionIndex += switch (instruction.turn) {
				case Left:
					-1;
				case Right:
					1;
			}
			directionIndex = Util.mod(directionIndex, directions.length);

			var direction = directions[directionIndex];
			var steps = instruction.steps;
			while (steps > 0) {
				switch (direction) {
					case North:
						y--;
					case South:
						y++;
					case West:
						x--;
					case East:
						x++;
				}
				steps--;
				if (!proceed(x, y)) {
					return;
				}
			}
		}
	}
}

private enum Turn {
	Left;
	Right;
}

private typedef Instruction = {
	var turn:Turn;
	var steps:Int;
}

private enum Direction {
	North;
	South;
	West;
	East;
}

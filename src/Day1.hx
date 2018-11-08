import utest.ITest;

class Day1 implements ITest {
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

	public static function getDistanceToHQ(sequence:String):Int {
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
			switch (direction) {
				case North:
					y -= steps;
				case South:
					y += steps;
				case West:
					x -= steps;
				case East:
					x += steps;
			}
		}

		return Std.int(Math.abs(x) + Math.abs(y));
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

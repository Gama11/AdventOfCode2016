package days;

class Day21 {
	static function parseOperations(input:String):Array<Operation> {
		var swapPositionsRe = ~/swap position (\d+) with position (\d+)/;
		var swapLettersRe = ~/swap letter ([a-z]) with letter ([a-z])/;
		var rotateRe = ~/rotate (left|right) (\d+) steps?/;
		var rotateOnLetterRe = ~/rotate based on position of letter ([a-z])/;
		var reverseRe = ~/reverse positions (\d+) through (\d+)/;
		var moveRe = ~/move position (\d+) to position (\d+)/;
		return input.split("\n").map(op -> {
			var re = swapPositionsRe;
			if (re.match(op)) {
				return SwapPositions(re.matchedInt(1), re.matchedInt(2));
			}
			re = swapLettersRe;
			if (re.match(op)) {
				return SwapLetters(re.matched(1), re.matched(2));
			}
			re = rotateRe;
			if (re.match(op)) {
				var direction = if (re.matched(1) == "left") Left else Right; 
				return Rotate(direction, re.matchedInt(2));
			}
			re = rotateOnLetterRe;
			if (re.match(op)) {
				return RotateOnLetter(re.matched(1));
			}
			re = reverseRe;
			if (re.match(op)) {
				return Reverse(re.matchedInt(1), re.matchedInt(2));
			}
			re = moveRe;
			if (re.match(op)) {
				return Move(re.matchedInt(1), re.matchedInt(2));
			}
			throw 'unknown operation: $op';
		});
	}

	static function swap<T>(a:Array<T>, i:Int, j:Int) {
		var temp = a[i];
		a[i] = a[j];
		a[j] = temp;
	}

	static function rotate<T>(a:Array<T>, steps:Int) {
		var absSteps = Std.int(Math.abs(steps));
		if (steps < 0) {
			for (_ in 0...absSteps) {
				a.push(a.shift());
			}
		} else if (steps > 0) {
			for (_ in 0...absSteps) {
				a.unshift(a.pop());
			}
		}
	}

	public static function scramble(input:String, password:String):String {
		var operations = parseOperations(input);
		var a = password.split("");
		for (operation in operations) {
			switch (operation) {
				case SwapPositions(x, y):
					swap(a, x, y);

				case SwapLetters(x, y):
					swap(a, a.indexOf(x), a.indexOf(y));

				case Rotate(Left, steps):
					rotate(a, -steps);

				case Rotate(Right, steps):
					rotate(a, steps);

				case RotateOnLetter(letter):
					var i = a.indexOf(letter);
					var steps = i + 1;
					if (i >= 4) {
						steps++;
					}
					rotate(a, steps);

				case Reverse(x, y):
					var reversed = [for (i in x...y + 1) a[i]];
					reversed.reverse();
					for (i in 0...reversed.length) {
						a[i + x] = reversed[i];
					}

				case Move(x, y):
					var letter = a[x];
					a.splice(x, 1);
					a.insert(y, letter);
			}
		}
		return a.join("");
	}
}

private enum Operation {
	SwapPositions(x:Int, y:Int);
	SwapLetters(x:String, y:String);
	Rotate(direction:Direction, steps:Int);
	RotateOnLetter(letter:String);
	Reverse(x:Int, y:Int);
	Move(x:Int, y:Int);
}

private enum abstract Direction(Int) {
	var Left = -1;
	var Right = 1;
}

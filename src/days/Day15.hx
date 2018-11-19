package days;

class Day15 {
	static function parseConfig(input:String):Array<Disc> {
		var regex = ~/Disc #[0-9]+ has ([0-9]+) positions; at time=0, it is at position ([0-9]+)\./;
		return input.split("\n").map(line -> {
			regex.match(line);
			return {
				pos: regex.matchedInt(2),
				max: regex.matchedInt(1)
			}
		});
	}

	public static function findTimeToPushButton(input:String):Int {
		var discs = parseConfig(input);
		var time = 0;

		var max = -1;
		var interval = 1;
		var prevMaxTime = 0;

		while (true) {
			for (i in 0...discs.length) {
				var disc = discs[i];
				var offset = i + 1;
				if ((disc.pos + offset + time) % disc.max != 0)  {
					break;
				}

				if (i == max) {
					interval = time - prevMaxTime;
				}
				if (i >= max) {
					max = i;
					prevMaxTime = time;
				}
				
				if (i == discs.length - 1) {
					// made it through
					return time;
				}
			}

			time += interval;
		}
		return -1;
	}
}

typedef Disc = {
	var pos:Int;
	var max:Int;
}

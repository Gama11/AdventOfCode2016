package days;


class Day20 {
	static function parseBlacklist(input:String):Array<Range> {
		return input.split("\n").map(range -> {
			var split = range.split("-");
			var min = Std.parseFloat(split[0]);
			var max = Std.parseFloat(split[1]);
			if (min == null || max == null) {
				throw 'invalid range: $range';
			}
			return {min: min, max: max};
		});
	}

	static function simplifyBlacklist(input:String):Array<Range> {
		var blacklist = parseBlacklist(input);
		blacklist.sort((range1, range2) -> {
			if (range2.min < range1.min) {
				return 1;
			} else if (range1.min < range2.min) {
				return -1;
			}
			return 0;
		});

		var simplifiedBlacklist = [];
		var prev = null;
		for (range in blacklist) {
			if (prev == null) {
				prev = range;
				continue;
			}
			if (prev.intersects(range)) {
				prev = prev.combine(range);
			} else {
				simplifiedBlacklist.push(prev);
				prev = range;
			}
		}
		if (prev != null) {
			simplifiedBlacklist.push(prev);
		}
		return simplifiedBlacklist;
	}

	public static function getLowestValidIP(input:String):Float {
		return simplifyBlacklist(input)[0].max + 1;
	}

	public static function countValidIPs(input:String):Int {
		var blacklist = simplifyBlacklist(input);
		var count = 0;
		for (i in 1...blacklist.length) {
			var space = blacklist[i].min - blacklist[i - 1].max - 1;
			count += Std.int(space);
		}
		return count;
	}
}

private typedef RangeData = {
	var min:Float;	
	var max:Float;	
}

@:forward private abstract Range(RangeData) from RangeData {
	public function intersects(other:Range):Bool {
		return (this.min <= other.min && this.max >= other.min)
			|| (this.min <= other.max && this.max >= other.max);
	}

	public function combine(other:Range):Range {
		var min = if (this.min < other.min) this.min else other.min;
		var max = if (this.max > other.max) this.max else other.max;
		return {min: min, max: max};
	}
}

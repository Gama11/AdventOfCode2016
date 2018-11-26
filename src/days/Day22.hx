package days;

class Day22 {
	static function parseInput(input:String):Array<Node> {
		var regex = ~/\/dev\/grid\/node-x(\d+)-y(\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T\s+(\d+)%/;
		var nodes = [];
		for (line in input.split("\n")) {
			if (regex.match(line)) {
				nodes.push({
					x: regex.matchedInt(1),
					y: regex.matchedInt(2),
					size: regex.matchedInt(3),
					used: regex.matchedInt(4),
					avail: regex.matchedInt(5),
					usePercent: regex.matchedInt(6)
				});
			}
		}
		return nodes;
	}

	public static function countViablePairs(input:String):Int {
		var nodes = parseInput(input);
		var count = 0;
		for (a in nodes) {
			for (b in nodes) {
				if (a == b) {
					continue;
				}
				if (a.used > 0 && a.used < b.avail) {
					count++;
				}
			}
		}
		return count;
	}
}

private typedef Node = {
	final x:Int;
	final y:Int;
	final size:Int;
	final used:Int;
	final avail:Int;
	final usePercent:Int;
}

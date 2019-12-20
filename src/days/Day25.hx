package days;

class Day25 {
	public static function findLowestClockSignalCode(input:String):Int {
		var checkLength = 10;
		var i = 0;
		while (true) {
			var next = 0;
			var streak = 0;
			Day23.executeAssembunny(input, i, function(out) {
				if (out != next) {
					return false;
				}
				streak++;
				if (streak > checkLength) {
					return false;
				}
				next = if (next == 0) 1 else 0;
				return true;
			});
			if (streak > checkLength) {
				return i;
			}
			i++;
		}
	}
}

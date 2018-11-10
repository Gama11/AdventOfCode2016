class Day6 {
	public static function getErrorCorrectedMessage(messages:String, strategy:Strategy):String {
		var frequencies = [];
		for (message in messages.split("\n")) {
			for (i in 0...message.length) {
				var column = frequencies[i];
				if (column == null) {
					column = new Map<String, Int>();
					frequencies[i] = column;
				}

				var letter = message.charAt(i);
				var count = column[letter];
				if (count == null) {
					count = 0;
				}
				column[letter] = count + 1;
			}
		}

		return frequencies.map(column -> {
			var letters = [for (letter in column.keys()) letter];
			letters.sort((s1, s2) -> switch (strategy) {
				case LeastCommon: column[s1] - column[s2];
				case MostCommon: column[s2] - column[s1];
			});
			return letters[0];
		}).join("");
	}
}

enum Strategy {
	MostCommon;
	LeastCommon;
}

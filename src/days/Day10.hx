package days;

class Day10 {
	static function buildFactory(instructions:String):Factory {
		var bots = new Map();
		var inputs = [];

		final initRegex = ~/value ([0-9]+) goes to bot ([0-9]+)/;
		final comparisonRegex = ~/bot ([0-9]+) gives low to (output|bot) ([0-9]+) and high to (output|bot) ([0-9]+)/;

		for (instruction in instructions.split("\n")) {
			if (initRegex.match(instruction)) {
				inputs.push({
					value: initRegex.matchedInt(1),
					bot: initRegex.matchedInt(2)
				});
			} else if (comparisonRegex.match(instruction)) {
				var bot = comparisonRegex.matchedInt(1);
				var lowType = comparisonRegex.matched(2);
				var lowID = comparisonRegex.matchedInt(3);
				var highType = comparisonRegex.matched(4);
				var highID = comparisonRegex.matchedInt(5);
				bots[bot] = new Bot(
					if (lowType == "bot") ToBot(lowID) else ToOutput(lowID),
					if (highType == "bot") ToBot(highID) else ToOutput(highID)
				);
			} else {
				throw 'unmatched instruction ' + instruction;
			}
		}

		return {
			bots: bots,
			inputs: inputs,
			outputs: new Map()
		};
	}

	public static function simulate(instructions:String):Result {
		var factory = buildFactory(instructions);
		for (input in factory.inputs) {
			factory.bots[input.bot].give(input.value);
		}

		var part1:Int = 0;
		var anyProgress;
		do {
			anyProgress = false;
			for (id => bot in factory.bots) {
				if (bot.lowValue == 17 && bot.highValue == 61) {
					part1 = id;
				}
				if (bot.process(factory)) {
					anyProgress = true;
				}
			}
		} while (anyProgress);
		
		return {
			part1: part1,
			part2: factory.outputs[0] * factory.outputs[1] * factory.outputs[2]
		};
	}
}

typedef Result = {
	part1:Int,
	part2:Int
}

enum Delivery {
	ToBot(id:Int);
	ToOutput(id:Int);
}

class Bot {
	public var lowValue:Null<Int>;
	public var highValue:Null<Int>;

	final low:Delivery;
	final high:Delivery;

	public function new(low:Delivery, high:Delivery) {
		this.low = low;
		this.high = high;
	}

	public function give(value:Int) {
		if (lowValue == null) {
			lowValue = value;
		} else if (highValue == null) {
			highValue = value;
		} else {
			throw 'already full';
		}

		if (lowValue > highValue) {
			var temp = lowValue;
			lowValue = highValue;
			highValue = temp;
		}
	}

	public function process(factory:Factory):Bool {
		if (lowValue == null || highValue == null) {
			return false;
		}
		inline function send(delivery:Delivery, value:Int) {
			switch (delivery) {
				case ToBot(id): factory.bots[id].give(value);
				case ToOutput(id): factory.outputs[id] = value;
			}
		}
		send(low, lowValue);
		send(high, highValue);
		lowValue = null;
		highValue = null;
		return true;
	}

	public function toString() {
		return '($lowValue | $highValue)';
	}
}

typedef Factory = {
	final bots:Map<Int, Bot>;
	final inputs:Array<{bot:Int, value:Int}>;
	final outputs:Map<Int, Int>;
}

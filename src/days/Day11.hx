package days;

class Day11 {
	public static function findMinimumSteps(facility:Facility) {
		trace(getPossibleMoves(facility, Up));
		trace(getPossibleMoves(facility, Down));
	}

	static function getPossibleMoves(facility:Facility, direction:MoveDirection):Array<Move> {
		var nextFloorID = facility.elevator + direction;
		if (nextFloorID < 0 || nextFloorID >= facility.floors.length) {
			return [];
		}
		var moves = [];
		var floor = facility.floors[facility.elevator];
		var nextFloor = facility.floors[nextFloorID];
		var nextFloorHasGenerators = nextFloor.exists(item -> item.match(Generator(_)));
		var unshieldedChips = nextFloor.filter(item -> {
			return switch (item) {
				case Generator(_):
					false;
				case Microchip(element):
					!nextFloor.exists(i -> i.equals(Generator(element)));
			}
		});

		inline function addMove(items:Array<Item>) {
			moves.push({
				direction: direction,
				items: items
			});
		}

		for (item in floor) {
			switch (item) {
				case Generator(element):
					var compatibleChip = Microchip(element);
					if (unshieldedChips.length == 0 && floor.exists(i -> i.equals(compatibleChip))) {
						addMove([item, compatibleChip]);
					}
					if (unshieldedChips.length == 1 && unshieldedChips[0].equals(compatibleChip)) {
						addMove([item]);
					}
				case _:
			}
		}

		function canChipBeBrought(chip:Item):Bool {
			return switch (chip) {
				case Generator(_): false;
				case Microchip(element):
					!nextFloorHasGenerators || nextFloor.exists(i -> i.equals(Generator(element)));
			}
		}
		var bringableChips = floor.filter(canChipBeBrought);
		for (chip in bringableChips) {
			for (chip2 in bringableChips) {
				if (chip.equals(chip2)) {
					continue;
				}
				if (!moves.exists(move -> chip2.equals(move.items[0]) && chip.equals(move.items[1]))) {
					addMove([chip, chip2]);
				}
			}
			addMove([chip]);
		}

		return moves;
	}
}

enum Item {
	Generator(element:String);
	Microchip(element:String);
}

typedef Facility = {
	var floors:Array<Array<Item>>;
	var elevator:Int;
}

typedef Move = {
	var direction:MoveDirection;
	var items:Array<Item>;
}

enum abstract MoveDirection(Int) to Int {
	var Up = 1;
	var Down = -1;
}

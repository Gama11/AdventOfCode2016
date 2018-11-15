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
		var nextFloorHasUnshieldedChips = nextFloor.exists(item -> {
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
					if (!nextFloorHasUnshieldedChips) {
						if (floor.exists(i -> i.equals(compatibleChip))) {
							addMove([item, compatibleChip]);
						}
						addMove([item]);
					}
				case Microchip(element):
					if (!nextFloorHasGenerators || nextFloor.exists(i -> i.equals(Generator(element)))) {
						addMove([item]);
					}

			}
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

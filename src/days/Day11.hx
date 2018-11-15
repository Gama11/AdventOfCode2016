package days;

class Day11 {
	public static function findMinimumSteps(facility:Facility):Float {
		var exploredFacilities = [];
		var min = Math.POSITIVE_INFINITY;
		function explore(facility:Facility, depth:Int) {
			if (depth > min) {
				return;
			}
			var uniqueString = getUniqueString(facility);
			if (exploredFacilities.indexOf(uniqueString) != -1) {
				return;
			}
			exploredFacilities.push(uniqueString);
			for (facility in getPossibleNextStates(facility)) {
				if (isComplete(facility)) {
					min = depth;
					return;
				}
				explore(facility, depth + 1);
			}
		}
		explore(facility, 0);
		return min;
	}

	static function isComplete(facility:Facility):Bool {
		var floors = facility.floors;
		// every floor except the last one should be empty
		for (i in 0...floors.length - 1) {
			if (floors[i].length > 0) {
				return false;
			}
		}
		return true;
	}

	static function isValidFloor(floor:Floor):Bool {
		if (floor.length == 0) {
			return true;
		}
		var generators = floor.filter(item -> item.match(Generator(_)));
		for (item in floor) {
			switch (item) {
				case Microchip(element):
					if (generators.length > 0 && !generators.exists(item -> item.equals(Generator(element)))) {
						return false;
					}
				case _:
			}
		}
		return true;
	}

	static function getItemCombinations(floor:Floor):Array<Array<Item>> {
		var itemCombinations:Array<Array<Item>> = [];
		for (i1 in floor) {
			for (i2 in floor) {
				if (!i1.equals(i2) && !itemCombinations.exists(t -> t[0].equals(i2) && t[1].equals(i1))) {
					itemCombinations.push([i1, i2]);
				}
			}
		}
		for (item in floor) {
			itemCombinations.push([item]);
		}
		return itemCombinations;
	}

	static function getPossibleNextStates(facility:Facility):Array<Facility> {
		var floor = facility.floors[facility.elevator];
		var combinations = getItemCombinations(floor);
		var nextStates = [];

		for (items in combinations) {
			var newFloor = floor.copy();
			for (item in items) {
				newFloor.remove(item);
			}
			if (!isValidFloor(newFloor)) {
				continue;
			}

			for (move in [1, -1]) {
				var nextFloorID = facility.elevator + move;
				if (nextFloorID < 0 || nextFloorID > facility.floors.length -1) {
					continue;
				}
				var nextFloor = facility.floors[nextFloorID];
				var newNextFloor = nextFloor.concat(items);
				
				var newFloors = facility.floors.copy();
				newFloors[facility.elevator] = newFloor;
				newFloors[nextFloorID] = newNextFloor;

				if (isValidFloor(newNextFloor)) {
					nextStates.push({
						floors: newFloors,
						elevator: nextFloorID
					});
				}
			}
		}

		return nextStates;
	}

	static function getUniqueString(facility:Facility):String {
		var floors = facility.floors.map(floor -> floor.map(item -> {
			switch (item) {
				case Generator(element): element.substr(0, 2) + "G";
				case Microchip(element): element.substr(0, 2) + "M";
			}
		}));
		for (floor in floors) {
			floor.sort(Reflect.compare);
		}
		return facility.elevator + "~" + floors.map(items -> items.join(" ")).join("|");
	}
}

enum Item {
	Generator(element:String);
	Microchip(element:String);
}

typedef Floor = Array<Item>;

typedef Facility = {
	var floors:Array<Floor>;
	var elevator:Int;
}

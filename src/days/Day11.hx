package days;

class Day11 {
	public static function findMinimumSteps(facility:Facility) {
		var exploredFacilities = [];
		for (floor in facility.floors) {
			trace(getItemCombinations(floor));
			trace(isValidFloor(floor));
		}
	}

	static function isValidFloor(floor:Floor):Bool {
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
}

enum Item {
	Generator(element:String);
	Microchip(element:String);
}

typedef Facility = {
	var floors:Array<Array<Item>>;
	var elevator:Int;
}

typedef Floor = Array<Item>;

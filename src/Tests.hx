import days.*;
import utest.ITest;
import utest.Assert;
import utest.UTest;

class Tests implements ITest {
	static function main() {
		UTest.run([new Tests()]);
	}

	function new() {}

	function getData(name:String):String {
		return sys.io.File.getContent('data/$name.txt').replace("\r", "");
	}

	function testDay01() {
		Assert.equals(5, Day1.getDistanceToHQ("R2, L3"));
		Assert.equals(2, Day1.getDistanceToHQ("R2, R2, R2"));
		Assert.equals(12, Day1.getDistanceToHQ("R5, L5, R5, R3"));
		Assert.equals(250, Day1.getDistanceToHQ(getData("day1")));

		Assert.equals(4, Day1.getDistanceToFirstVisitedTwice("R8, R4, R4, R8"));
		Assert.equals(151, Day1.getDistanceToFirstVisitedTwice(getData("day1")));
	}

	function testDay02() {
		Assert.equals("1985", Day2.getTestCode(getData("day2-0")));
		Assert.equals("18843", Day2.getTestCode(getData("day2-1")));

		Assert.equals("5DB3", Day2.getActualCode(getData("day2-0")));
		Assert.equals("67BB9", Day2.getActualCode(getData("day2-1")));
	}

	function testDay03() {
		Assert.isFalse(Day3.isPossibleTriangle(5, 10, 25));
		Assert.equals(983, Day3.countPossibleTrianglesByRow(getData("day3")));

		Assert.equals(1836, Day3.countPossibleTrianglesByColumn(getData("day3")));
	}

	function testDay04() {
		Assert.isTrue(Day4.checkRoom("aaaaa-bbb-z-y-x-123[abxyz]").match(Real(_)));
		Assert.isTrue(Day4.checkRoom("a-b-c-d-e-f-g-h-987[abcde]").match(Real(_)));
		Assert.isTrue(Day4.checkRoom("not-a-real-room-404[oarel]").match(Real(_)));
		Assert.isFalse(Day4.checkRoom("totally-real-room-200[decoy]").match(Real(_)));
		Assert.equals(173787, Day4.sumRealRoomIDs(getData("day4")));

		Assert.equals("very encrypted name", Day4.decrypt("qzmt-zixmtkozy-ivhz-343").name);
		Assert.equals(548, Day4.findIDforName(getData("day4"), "northpole object storage"));
	}

	@Ignored
	function testDay05() {
		Assert.equals("18f47a30", Day5.findPassword("abc"));
		Assert.equals("f77a0e6e", Day5.findPassword("cxdnnyjw"));

		Assert.equals("05ace8e3", Day5.findPassword2("abc"));
		Assert.equals("999828ec", Day5.findPassword2("cxdnnyjw"));
	}

	function testDay06() {
		Assert.equals("easter", Day6.getErrorCorrectedMessage(getData("day6-0"), MostCommon));
		Assert.equals("qoclwvah", Day6.getErrorCorrectedMessage(getData("day6-1"), MostCommon));

		Assert.equals("advent", Day6.getErrorCorrectedMessage(getData("day6-0"), LeastCommon));
		Assert.equals("ryrgviuv", Day6.getErrorCorrectedMessage(getData("day6-1"), LeastCommon));
	}

	function testDay07() {
		Assert.isTrue(Day7.supportsTLS("abba[mnop]qrst"));
		Assert.isFalse(Day7.supportsTLS("abcd[bddb]xyyx"));
		Assert.isFalse(Day7.supportsTLS("aaaa[qwer]tyui"));
		Assert.isTrue(Day7.supportsTLS("ioxxoj[asdfgh]zxcvbn"));
		Assert.equals(115, Day7.count(getData("day7"), Day7.supportsTLS));

		Assert.isTrue(Day7.supportsSSL("aba[bab]xyz"));
		Assert.isFalse(Day7.supportsSSL("xyx[xyx]xyx"));
		Assert.isTrue(Day7.supportsSSL("aaa[kek]eke"));
		Assert.isTrue(Day7.supportsSSL("zazbz[bzb]cdb"));
		Assert.equals(231, Day7.count(getData("day7"), Day7.supportsSSL));
	}

	@Ignored
	function testDay08() {
		Day8.visualize(7, 3, [
			Rect(3, 2),
			RotateColumn(1, 1),
			RotateRow(0, 4),
			RotateColumn(1, 1)
		]);

		Assert.equals(106, Day8.determineLitPixelCount(50, 6, getData("day8")));
		// part 2
		// Day8.visualize(50, 6, Day8.parseOperations(getData("day8")));
	}

	function testDay09() {
		Assert.equals("ADVENT".length, Day9.decompress("ADVENT", false));
		Assert.equals("ABBBBBC".length, Day9.decompress("A(1x5)BC", false));
		Assert.equals("XYZXYZXYZ".length, Day9.decompress("(3x3)XYZ", false));
		Assert.equals("ABCBCDEFEFG".length, Day9.decompress("A(2x2)BCD(2x2)EFG", false));
		Assert.equals("(1x3)A".length, Day9.decompress("(6x1)(1x3)A", false));
		Assert.equals("X(3x3)ABC(3x3)ABCY".length, Day9.decompress("X(8x2)(3x3)ABCY", false));
		Assert.equals(138735, Day9.decompress(getData("day9"), false));

		Assert.equals("XYZXYZXYZ".length, Day9.decompress("(3x3)XYZ", true));
		Assert.equals("XABCABCABCABCABCABCY".length, Day9.decompress("X(8x2)(3x3)ABCY", true));
		Assert.equals(241920, Day9.decompress("(27x12)(20x12)(13x14)(7x10)(1x12)A", true));
		Assert.equals(445, Day9.decompress("(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN", true));
		Assert.equals(11125026826, Day9.decompress(getData("day9"), true));
	}

	function testDay10() {
		var result = Day10.simulate(getData("day10"));
		Assert.equals(113, result.part1);
		Assert.equals(12803, result.part2);
	}

	@Ignored
	function testDay11() {
		Assert.equals(11, Day11.findMinimumSteps({
			elevator: 0,
			floors: [
				[Microchip("hydrogen"), Microchip("lithium")],
				[Generator("hydrogen")],
				[Generator("lithium")],
				[]
			]
		}));

		Assert.equals(33, Day11.findMinimumSteps({
			elevator: 0,
			floors: [
				[Generator("promethium"), Microchip("promethium")],
				[Generator("cobalt"), Generator("curium"), Generator("ruthenium"), Generator("plutonium")],
				[Microchip("cobalt"), Microchip("curium"), Microchip("ruthenium"), Microchip("plutonium")],
				[]
			]
		}));

		Assert.equals(57, Day11.findMinimumSteps({
			elevator: 0,
			floors: [
				[Generator("elerium"), Microchip("elerium"), Generator("dilithium"), Microchip("dilithium"), Generator("promethium"), Microchip("promethium")],
				[Generator("cobalt"), Generator("curium"), Generator("ruthenium"), Generator("plutonium")],
				[Microchip("cobalt"), Microchip("curium"), Microchip("ruthenium"), Microchip("plutonium")],
				[]
			]
		}));
	}
}

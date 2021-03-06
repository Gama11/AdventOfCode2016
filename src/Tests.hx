import Util.Point;
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
		Assert.equals(5, Day01.getDistanceToHQ("R2, L3"));
		Assert.equals(2, Day01.getDistanceToHQ("R2, R2, R2"));
		Assert.equals(12, Day01.getDistanceToHQ("R5, L5, R5, R3"));
		Assert.equals(250, Day01.getDistanceToHQ(getData("day01")));

		Assert.equals(4, Day01.getDistanceToFirstVisitedTwice("R8, R4, R4, R8"));
		Assert.equals(151, Day01.getDistanceToFirstVisitedTwice(getData("day01")));
	}

	function testDay02() {
		Assert.equals("1985", Day02.getTestCode(getData("day02-0")));
		Assert.equals("18843", Day02.getTestCode(getData("day02-1")));

		Assert.equals("5DB3", Day02.getActualCode(getData("day02-0")));
		Assert.equals("67BB9", Day02.getActualCode(getData("day02-1")));
	}

	function testDay03() {
		Assert.isFalse(Day03.isPossibleTriangle(5, 10, 25));
		Assert.equals(983, Day03.countPossibleTrianglesByRow(getData("day03")));

		Assert.equals(1836, Day03.countPossibleTrianglesByColumn(getData("day03")));
	}

	function testDay04() {
		Assert.isTrue(Day04.checkRoom("aaaaa-bbb-z-y-x-123[abxyz]").match(Real(_)));
		Assert.isTrue(Day04.checkRoom("a-b-c-d-e-f-g-h-987[abcde]").match(Real(_)));
		Assert.isTrue(Day04.checkRoom("not-a-real-room-404[oarel]").match(Real(_)));
		Assert.isFalse(Day04.checkRoom("totally-real-room-200[decoy]").match(Real(_)));
		Assert.equals(173787, Day04.sumRealRoomIDs(getData("day04")));

		Assert.equals("very encrypted name", Day04.decrypt("qzmt-zixmtkozy-ivhz-343").name);
		Assert.equals(548, Day04.findIDforName(getData("day04"), "northpole object storage"));
	}

	@Ignored
	function testDay05() {
		Assert.equals("18f47a30", Day05.findPassword("abc"));
		Assert.equals("f77a0e6e", Day05.findPassword("cxdnnyjw"));

		Assert.equals("05ace8e3", Day05.findPassword2("abc"));
		Assert.equals("999828ec", Day05.findPassword2("cxdnnyjw"));
	}

	function testDay06() {
		Assert.equals("easter", Day06.getErrorCorrectedMessage(getData("day06-0"), MostCommon));
		Assert.equals("qoclwvah", Day06.getErrorCorrectedMessage(getData("day06-1"), MostCommon));

		Assert.equals("advent", Day06.getErrorCorrectedMessage(getData("day06-0"), LeastCommon));
		Assert.equals("ryrgviuv", Day06.getErrorCorrectedMessage(getData("day06-1"), LeastCommon));
	}

	function testDay07() {
		Assert.isTrue(Day07.supportsTLS("abba[mnop]qrst"));
		Assert.isFalse(Day07.supportsTLS("abcd[bddb]xyyx"));
		Assert.isFalse(Day07.supportsTLS("aaaa[qwer]tyui"));
		Assert.isTrue(Day07.supportsTLS("ioxxoj[asdfgh]zxcvbn"));
		Assert.equals(115, Day07.count(getData("day07"), Day07.supportsTLS));

		Assert.isTrue(Day07.supportsSSL("aba[bab]xyz"));
		Assert.isFalse(Day07.supportsSSL("xyx[xyx]xyx"));
		Assert.isTrue(Day07.supportsSSL("aaa[kek]eke"));
		Assert.isTrue(Day07.supportsSSL("zazbz[bzb]cdb"));
		Assert.equals(231, Day07.count(getData("day07"), Day07.supportsSSL));
	}

	@Ignored
	function testDay08() {
		Day08.visualize(7, 3, [Rect(3, 2), RotateColumn(1, 1), RotateRow(0, 4), RotateColumn(1, 1)]);

		Assert.equals(106, Day08.determineLitPixelCount(50, 6, getData("day08")));
		// part 2
		// Day08.visualize(50, 6, Day08.parseOperations(getData("day08")));
	}

	function testDay09() {
		Assert.equals("ADVENT".length, Day09.decompress("ADVENT", false));
		Assert.equals("ABBBBBC".length, Day09.decompress("A(1x5)BC", false));
		Assert.equals("XYZXYZXYZ".length, Day09.decompress("(3x3)XYZ", false));
		Assert.equals("ABCBCDEFEFG".length, Day09.decompress("A(2x2)BCD(2x2)EFG", false));
		Assert.equals("(1x3)A".length, Day09.decompress("(6x1)(1x3)A", false));
		Assert.equals("X(3x3)ABC(3x3)ABCY".length, Day09.decompress("X(8x2)(3x3)ABCY", false));
		Assert.equals(138735, Day09.decompress(getData("day09"), false));

		Assert.equals("XYZXYZXYZ".length, Day09.decompress("(3x3)XYZ", true));
		Assert.equals("XABCABCABCABCABCABCY".length, Day09.decompress("X(8x2)(3x3)ABCY", true));
		Assert.equals(241920, Day09.decompress("(27x12)(20x12)(13x14)(7x10)(1x12)A", true));
		Assert.equals(445, Day09.decompress("(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN", true));
		Assert.equals(11125026826, Day09.decompress(getData("day09"), true));
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
				[
					Generator("cobalt"),
					Generator("curium"),
					Generator("ruthenium"),
					Generator("plutonium")
				],
				[
					Microchip("cobalt"),
					Microchip("curium"),
					Microchip("ruthenium"),
					Microchip("plutonium")
				],
				[]
			]
		}));

		Assert.equals(57, Day11.findMinimumSteps({
			elevator: 0,
			floors: [
				[
					Generator("elerium"),
					Microchip("elerium"),
					Generator("dilithium"),
					Microchip("dilithium"),
					Generator("promethium"),
					Microchip("promethium")
				],
				[
					Generator("cobalt"),
					Generator("curium"),
					Generator("ruthenium"),
					Generator("plutonium")
				],
				[
					Microchip("cobalt"),
					Microchip("curium"),
					Microchip("ruthenium"),
					Microchip("plutonium")
				],
				[]
			]
		}));
	}

	@Ignored
	function testDay12() {
		Assert.equals(318117, Day12.executeAssembunny(getData("day12"), 0)["a"]);
		Assert.equals(9227771, Day12.executeAssembunny(getData("day12"), 1)["a"]);
	}

	@Ignored
	function testDay13() {
		Assert.equals(1, Day13.countBinaryOnes(1));
		Assert.equals(1, Day13.countBinaryOnes(2));
		Assert.equals(2, Day13.countBinaryOnes(3));
		Assert.equals(8, Day13.countBinaryOnes(255));
		Assert.equals(1, Day13.countBinaryOnes(256));

		var exampleMap = Day13.isWall.bind(_, _, 10);
		Assert.isFalse(exampleMap(0, 0));
		Assert.isFalse(exampleMap(0, 1));
		Assert.isTrue(exampleMap(1, 0));
		Assert.isTrue(exampleMap(9, 6));

		Assert.equals(11, Day13.findDistance(new Point(7, 4), 10).fewestStepsToGoal);
		var result = Day13.findDistance(new Point(31, 39), 1364);
		Assert.equals(86, result.fewestStepsToGoal);
		Assert.equals(127, result.reachableIn50Steps - 3);
	}

	@Ignored
	function testDay14() {
		Assert.equals("8", Day14.characterInRow("cc38887a5", 3));
		Assert.equals(null, Day14.characterInRow("cc38887a5", 4));
		Assert.equals("7", Day14.characterInRow("cc388877777a5", 4));
		Assert.equals(22728, Day14.get64thKeyIndex("abc"));
		Assert.equals(15168, Day14.get64thKeyIndex("qzyelonm"));

		Assert.equals(20864, Day14.get64thKeyIndex("qzyelonm", 2016));
	}

	function testDay15() {
		Assert.equals(5, Day15.findTimeToPushButton(getData("day15-0")));
		Assert.equals(400589, Day15.findTimeToPushButton(getData("day15-1")));
		Assert.equals(3045959, Day15.findTimeToPushButton(getData("day15-2")));
	}

	@Ignored
	function testDay16() {
		Assert.equals("100", Day16.generateData("1"));
		Assert.equals("001", Day16.generateData("0"));
		Assert.equals("11111000000", Day16.generateData("11111"));
		Assert.equals("1111000010100101011110000", Day16.generateData("111100001010"));
		Assert.equals("100", Day16.calculateChecksum("110010110100"));
		Assert.equals("01100", Day16.fillDisk("10000", 20));
		Assert.equals("10010010110011010", Day16.fillDisk("01000100010010111", 272));
		Assert.equals("01010100101011100", Day16.fillDisk("01000100010010111", 35651584));
	}

	@Ignored
	function testDay17() {
		Assert.equals("DDRRRD", Day17.findPath("ihgpwlah", Shortest));
		Assert.equals("DDUDRLRRUDRD", Day17.findPath("kglvqrro", Shortest));
		Assert.equals("DRURDRUDDLLDLUURRDULRLDUUDDDRR", Day17.findPath("ulqzkmiv", Shortest));
		Assert.equals("RDDRULDDRR", Day17.findPath("ioramepc", Shortest));

		Assert.equals(370, Day17.findPath("ihgpwlah", Longest).length);
		Assert.equals(492, Day17.findPath("kglvqrro", Longest).length);
		Assert.equals(830, Day17.findPath("ulqzkmiv", Longest).length);
		Assert.equals(766, Day17.findPath("ioramepc", Longest).length);
	}

	@Ignored
	function testDay18() {
		Assert.equals(1961, Day18.countSafeTiles(getData("day18"), 40));
		Assert.equals(20000795, Day18.countSafeTiles(getData("day18"), 400000));
	}

	@Ignored
	function testDay19() {
		Assert.equals(3, Day19.getWinner(5));
		Assert.equals(1816277, Day19.getWinner(3005290));

		Assert.equals(2, Day19.getWinner2(5));
		Assert.equals(1410967, Day19.getWinner2(3005290));
	}

	function testDay20() {
		Assert.equals(17348574, Day20.getLowestValidIP(getData("day20")));
		Assert.equals(104, Day20.countValidIPs(getData("day20")));
	}

	function testDay21() {
		Assert.equals("decab", Day21.scramble(getData("day21-0"), "abcde"));
		Assert.equals("gcedfahb", Day21.scramble(getData("day21-1"), "abcdefgh"));

		Assert.equals("abcde", Day21.unscramble(getData("day21-0"), "decab"));
		Assert.equals("abcdefgh", Day21.unscramble(getData("day21-1"), "gcedfahb"));
		Assert.equals("hegbdcfa", Day21.unscramble(getData("day21-1"), "fbgdceah"));
	}

	@Ignored
	function testDay22() {
		Assert.equals(985, Day22.countViablePairs(getData("day22")));
		Assert.equals(179, Day22.findMinimumDataAccessSteps(getData("day22")));
	}

	@Ignored
	function testDay23() {
		Assert.equals(3, Day23.executeAssembunny(getData("day23-0"), 0)["a"]);
		Assert.equals(11123, Day23.executeAssembunny(getData("day23-1"), 7)["a"]);
		Assert.equals(479007683, Day23.executeAssembunny(getData("day23-1"), 12)["a"]);
	}

	function testDay24() {
		Assert.equals(14, Day24.findShortestPath(getData("day24-0"), false));
		Assert.equals(456, Day24.findShortestPath(getData("day24-1"), false));

		Assert.equals(704, Day24.findShortestPath(getData("day24-1"), true));
	}

	function testDay25() {
		Assert.equals(180, Day25.findLowestClockSignalCode(getData("day25")));
	}
}

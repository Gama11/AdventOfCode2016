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

	function testDay1() {
		Assert.equals(5, Day1.getDistanceToHQ("R2, L3"));
		Assert.equals(2, Day1.getDistanceToHQ("R2, R2, R2"));
		Assert.equals(12, Day1.getDistanceToHQ("R5, L5, R5, R3"));
		Assert.equals(250, Day1.getDistanceToHQ(getData("day1")));

		Assert.equals(4, Day1.getDistanceToFirstVisitedTwice("R8, R4, R4, R8"));
		Assert.equals(151, Day1.getDistanceToFirstVisitedTwice(getData("day1")));
	}

	function testDay2() {
		Assert.equals("1985", Day2.getTestCode(getData("day2-0")));
		Assert.equals("18843", Day2.getTestCode(getData("day2-1")));

		Assert.equals("5DB3", Day2.getActualCode(getData("day2-0")));
		Assert.equals("67BB9", Day2.getActualCode(getData("day2-1")));
	}

	function testDay3() {
		Assert.isFalse(Day3.isPossibleTriangle(5, 10, 25));
		Assert.equals(983, Day3.countPossibleTrianglesByRow(getData("day3")));

		Assert.equals(1836, Day3.countPossibleTrianglesByColumn(getData("day3")));
	}

	function testDay4() {
		Assert.isTrue(Day4.checkRoom("aaaaa-bbb-z-y-x-123[abxyz]").match(Real(_)));
		Assert.isTrue(Day4.checkRoom("a-b-c-d-e-f-g-h-987[abcde]").match(Real(_)));
		Assert.isTrue(Day4.checkRoom("not-a-real-room-404[oarel]").match(Real(_)));
		Assert.isFalse(Day4.checkRoom("totally-real-room-200[decoy]").match(Real(_)));
		Assert.equals(173787, Day4.sumRealRoomIDs(getData("day4")));

		Assert.equals("very encrypted name", Day4.decrypt("qzmt-zixmtkozy-ivhz-343").name);
		Assert.equals(0, Day4.findIDforName(getData("day4"), "northpole object storage"));
	}
}

import utest.Assert;
import utest.UTest;

class Tests {
	static function main() {
		UTest.run([new Tests()]);
	}

	function new() {}

	function getData(name:String):String {
		return sys.io.File.getContent('data/$name.txt');
	}

	function testDay1() {
		Assert.equals(5, Day1.getDistanceToHQ("R2, L3"));
		Assert.equals(2, Day1.getDistanceToHQ("R2, R2, R2"));
		Assert.equals(12, Day1.getDistanceToHQ("R5, L5, R5, R3"));
		Assert.equals(250, Day1.getDistanceToHQ(getData("day1")));

		Assert.equals(4, Day1.getDistanceToFirstVisitedTwice("R8, R4, R4, R8"));
		Assert.equals(151, Day1.getDistanceToFirstVisitedTwice(getData("day1")));
	}
}

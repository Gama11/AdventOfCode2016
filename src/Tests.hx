import utest.Assert;
import utest.UTest;

class Tests {
	static function main() {
		UTest.run([new Tests()]);
	}

	function new() {}

	function testSomething() {
		Assert.isTrue(false);
	}
}

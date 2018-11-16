package days;

class Day12 {
	static function parseInstructions(input:String):Array<Instruction> {
		return input.split("\n").map(instruction -> {
			var v = instruction.split(" ");
			switch (v[0]) {
				case "cpy": Copy(parseValue(v[1]), v[2]);
				case "inc": Increment(v[1]);
				case "dec": Decrement(v[1]);
				case "jnz": JumpNotZero(v[1], Std.parseInt(v[2]));
				case code: throw 'unknown instruction $code';
			}
		});
	}

	static function parseValue(input:String):Value {
		var value = Std.parseInt(input);
		if (value == null) {
			return Indirect(input);
		}
		return Direct(value);
	}

	public static function executeAssembunny(input:String):Registers {
		var registers:Registers = [
			"a" => 0,
			"b" => 0,
			"c" => 0,
			"d" => 0
		];
		var instructions = parseInstructions(input);
		var i = 0;
		while (i < instructions.length) {
			switch (instructions[i]) {
				case Copy(value, to):
					registers[to] = switch (value) {
						case Direct(value): value;
						case Indirect(register): registers[register];
					}
				case Increment(register):
					registers[register]++;
				case Decrement(register):
					registers[register]--;
				case JumpNotZero(register, offset):
					if (registers[register] != 0) {
						i += offset;
						continue;
					}
			}
			i++;
		}
		return registers;
	}
}

enum Instruction {
	Copy(value:Value, to:Register);
	Increment(register:Register);
	Decrement(register:Register);
	JumpNotZero(register:Register, offset:Int);
}

enum Value {
	Direct(value:Int);
	Indirect(register:Register);
}

abstract Register(String) from String {}

typedef Registers = Map<Register, Int>;

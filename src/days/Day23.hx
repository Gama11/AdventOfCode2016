package days;

class Day23 {
	static function parseInstructions(input:String):Array<Instruction> {
		return input.split("\n").map(instruction -> {
			var v = instruction.split(" ");
			switch (v[0]) {
				case "cpy": Copy(parseValue(v[1]), parseValue(v[2]));
				case "inc": Increment(v[1]);
				case "dec": Decrement(v[1]);
				case "jnz": JumpNotZero(parseValue(v[1]), parseValue(v[2]));
				case "tgl": Toggle(v[1]);
				case "out": Out(parseValue(v[1]));
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

	public static function executeAssembunny(input:String, keypad:Int, ?out:Int->Bool):Registers {
		var registers:Registers = ["a" => keypad, "b" => 0, "c" => 0, "d" => 0];
		var instructions = parseInstructions(input);
		var i = 0;
		function read(value:Value):Int {
			return switch (value) {
				case Direct(value): value;
				case Indirect(register): registers[register];
			}
		}
		while (i < instructions.length) {
			switch (instructions[i]) {
				case Copy(value, to):
					switch (to) {
						case Indirect(register):
							registers[register] = read(value);
						case _: // invalid
					}
				case Increment(register):
					registers[register]++;
				case Decrement(register):
					registers[register]--;
				case JumpNotZero(value, offset):
					if (read(value) != 0) {
						i += read(offset);
						continue;
					}
				case Toggle(register):
					var offset = i + registers[register];
					var instruction = instructions[offset];
					if (instruction != null) {
						instructions[offset] = switch (instruction) {
							case Copy(value, to): JumpNotZero(value, to);
							case Increment(register): Decrement(register);
							case Decrement(register): Increment(register);
							case JumpNotZero(register, offset): Copy(register, offset);
							case Toggle(register): Increment(register);
							case _: throw "unsupported toggle";
						}
					}
				case Out(value):
					if (out == null) {
						throw "no output connected";
					}
					if (!out(read(value))) {
						return registers;
					}
			}
			i++;
		}
		return registers;
	}
}

private enum Instruction {
	Copy(value:Value, to:Value);
	Increment(register:Register);
	Decrement(register:Register);
	JumpNotZero(value:Value, offset:Value);
	Toggle(register:Register);
	Out(value:Value);
}

private enum Value {
	Direct(value:Int);
	Indirect(register:Register);
}

private abstract Register(String) from String {}
private typedef Registers = Map<Register, Int>;

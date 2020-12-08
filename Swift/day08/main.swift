typealias Instruction = (op: String, arg: Int)
typealias InterpretContext = (pointer: Int, acc: Int)

let instructions: [Instruction] = readLines(from: "input", ofType: "txt")
  .map { line in line.components(separatedBy: " ") }
  .map { pair in Instruction(pair[0], Int(pair[1]) ?? 0) }

// Example 01
func next(_ context: InterpretContext, with instruction: Instruction) -> InterpretContext {
  let (pointer, acc) = context
  let (op, arg) = instruction
  switch op {
    case "jmp": return (pointer + arg, acc)
    case "acc": return (pointer + 1, acc + arg)
    default: return (pointer + 1 , acc)
  }
}

func run(with instructions: [Instruction]) -> InterpretContext {
  var context = InterpretContext(0, 0)
  var visited = Array(repeating: false, count: instructions.count)

  while context.pointer < instructions.count && !visited[context.pointer] {
    visited[context.pointer] = true
    context = next(context, with: instructions[context.pointer])
  }

  return context;
}

print("Example 01: \(run(with: instructions))")

// Example 02
let changes: [(Int, Instruction)] = instructions.enumerated()
  .filter { $1.op == "nop" || $1.op == "jmp" }
  .map { (index, element) in
    let newOp = element.op == "nop" ? "jmp" : "nop"
    return (index, (newOp, element.arg))
  }

for change in changes {
  var newInstructions = instructions
  newInstructions[change.0] = change.1

  let result = run(with: newInstructions)
  if result.pointer == newInstructions.count {
    print("Example 02: \(result), changed: \(change)")
    break;
  }
}

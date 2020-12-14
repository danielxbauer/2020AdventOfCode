typealias Rule = (_ mask: String, _ address: Int, _ value: Int) -> (addresses:[Int], value: Int)

// Calculates all combination. e.g. [["0", "1"], ["0", "1"]] -> ["00", "01", "10", "11"]
func combination(_ arrays: [[String]]) -> [String] {
  return arrays.dropFirst().reduce(into: arrays.first ?? []) { result, next in
    result = next.map { r in result.map { l in r + l }}.flatMap { $0 }
  }
}

func applyBitmask(_ mask: String, with address: Int, to value: Int) -> ([Int], Int) {
  let binary = String(value, radix: 2).leftPad(to: mask.count, with: "0")
  let newBinary = String(zip(binary, mask).map { v, m in m == "X" ? v : m })
  let newValue = Int(newBinary, radix: 2) ?? 0

  return ([address], newValue)
}

func applyAddressDecoder(_ mask: String, with address: Int, to value: Int) -> ([Int], Int) {
  let binary = String(address, radix: 2).leftPad(to: mask.count, with: "0")
  let newAddress = String(zip(binary, mask).map { v, m in m == "0" ? v : m })

  // Replace all X with all combinations:
  // 1. Get positions of "X" in newAddress
  let xs = newAddress.enumerated()
    .filter { $1 == "X" }
    .map { newAddress.index(offsetBy: $0.0)..<newAddress.index(offsetBy: $0.0 + 1) }
  
  // 2. Get all combinations (if 3Xs) => ["000", "001", ... , "111"]
  let combinations = combination(Array(repeating: ["0", "1"], count: xs.count)) 

  // 3. Replace Xs with combinations
  let addresses = combinations
    .map { changes -> String in
      var address = String(newAddress)
      for (change, x) in zip(changes, xs) {
        address.replaceSubrange(x, with: String(change))
      }

      return address
    }
    .map { Int($0, radix: 2) ?? -1 } // 4. Binary to int

  return (addresses, value)
}

func apply(instructions: [String], to memory: [Int: Int], rule: Rule) -> [Int: Int] {
  var memory = memory
  var mask = String(repeating: "X", count: 36)
  for instruction in instructions {
    let instructionComponents = instruction.components(separatedBy: " = ")
    let command = instructionComponents[0]
    let value = instructionComponents[1]

    switch command {
      case "mask": mask = value
      case let command where command.starts(with: "mem"):
        if let address = Int(command.matches(for: "\\d+")[0][0]), 
           let value = Int(value
        ) {
          let (addresses, newValue) = rule(mask, address, value)
          for address in addresses {
            memory[address] = newValue
          }
        }

      default: print("error")
    }
  }

  return memory
}

let lines = readLines(from: "input", ofType: "txt")

// Example 01
print("Example01")
let memory1 = apply(instructions: lines, to: [:], rule: applyBitmask)
print("Sum of memory is: \(memory1.reduce(0) { $0 + $1.1 })")

// Example 02
print("\nExample02")
let memory2 = apply(instructions: lines, to: [:], rule: applyAddressDecoder)
print("Sum of memory is: \(memory2.reduce(0) { $0 + $1.1 })")

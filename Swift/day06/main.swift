import Foundation

let data = readContent(from: "input", ofType: "txt")

// Example 01
let questions1 = data.components(separatedBy: "\n\n")
  .map { $0.replacingOccurrences(of: "\n", with: "") }
  .map { Set(Array($0)).count }
  .reduce(0, +)
print(questions1)

// Example 02
let questions2 = data.components(separatedBy: "\n\n")
  .map { $0
    .components(separatedBy: "\n")
    .map { Set(Array($0)) }
  }
  .map { $0
    .reduce($0.first!) { a, b in a.intersection(b) }
    .count
  }
  .reduce(0, +)

print(questions2)
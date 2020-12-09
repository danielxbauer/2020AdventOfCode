let offset = 25
let data = readLines(from: "input", ofType: "txt").map { Int($0)! }

func search(for index: Int, in data: [Int], _ offset: Int) -> Bool {
  for i in (index-offset)..<index {
    for j in i..<index where i != j {
      if data[i] + data[j] == data[index] {
        return true
      }
    }
  }

  return false
}

func contiguous(for index: Int, in data: [Int]) -> [Int]? {
  for i in 0..<data.count {
    var sum = 0
    for j in i..<data.count {
      sum += data[j]
      if sum == data[index] {
        return Array(data[i...j])
      }
    }
  }

  return nil
}

// Example 01
for index in offset..<data.count {
  if !search(for: index, in: data, offset) {
    print("Example 01: breaks the rule: \(data[index]) at index \(index)")

    // Example 02
    if let cont = contiguous(for: index, in: data) {
      let min = cont.min() ?? -1
      let max = cont.max() ?? -1
      print("Example 02: \(min + max)")
    }

    break
  }
}

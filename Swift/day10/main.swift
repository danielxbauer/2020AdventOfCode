let input = readLines(from: "input", ofType: "txt").map { Int($0)! }
let max = (input.max() ?? 0) + 3
let data = ([0, max] + input).sorted()

// Example 01
let diffs = zip(data, data.dropFirst()).map { $1 - $0 }
let diff1 = diffs.filter { $0 == 1 }.count
let diff3 = diffs.filter { $0 == 3 }.count
print("Example 01: \(diff1 * diff3)")

// Example 02
func getNeighbours(from data: [Int]) -> [Int: [Int]] {
  var next: [Int: [Int]] = [:]

  for (i, value) in data.enumerated() {
    var neighbours: [Int] = []
    for j in (i+1)...(i+3) where j < data.count {
      if data[j] - data[i] <= 3 {
        neighbours.append(data[j])
      }
    }
    
    next[value] = neighbours
  }

  return next
}

let next = getNeighbours(from: data)
var counts = next.reduce(into: [:]) { r, e in 
  r[e.key] = 1 
}

for (key, value) in next.sorted(by: { $0.key > $1.key }) {
  if !value.isEmpty {
    counts[key] = value.map { counts[$0] ?? 0 }.reduce(0, +)  
  }
}

print("Example 02: \(counts[0] ?? -1)")

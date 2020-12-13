let data = readLines(from: "input", ofType: "txt")
let arrivalTime = Int(data[0]) ?? 0

// Example 01
print("Example 01")
let buses = data[1].components(separatedBy: ",")
  .map { Int($0) ?? -1 }
  .filter { $0 != -1 }

let nextArrivals = buses.map { bus -> (bus: Int, nextArrival: Int) in
    let nextArrival = bus - (arrivalTime % bus)
    return (bus: bus, nextArrival: nextArrival)
  }
  .sorted { $0.nextArrival < $1.nextArrival }

if let nextBus = nextArrivals.first {
  print("Next bus in \(nextBus.nextArrival) min take bus \(nextBus.bus)")
  print("Result is \(nextBus.bus * nextBus.nextArrival)")
} else {
  print("Seems like no buses are available right now 😪")
}

// Example 02
print("\nExample 02")
// NOTE: I didn't come up with a better solution than just generating an equatation, pasting this to www.wolframalpha.com and coping the solution (look at "integer solution"). It does work though 😅
let equatation = data[1].components(separatedBy: ",")
  .enumerated()
  .map { ($0, Int($1) ?? -1) }
  .filter { $0.1 != -1 }
  .map { "(x + \($0.0)) mod \($0.1) = 0;" }
  .joined(separator: "")
print(equatation)
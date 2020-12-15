print("Day 15 - lets gooooo")

func puzzle(_ played: [Int], until: Int) -> Int {
  var currentTurn = played.count
  var lastPlayed = played.last!
  var pot2: [Int: Int] = played.enumerated()
    .reduce(into: [:]) { result, next in 
      result[next.1] = next.0
    }
  var pot1: [Int: Int] = [:]

  while currentTurn < until {
    if let p1 = pot1[lastPlayed],
       let p2 = pot2[lastPlayed] {
        lastPlayed = p2 - p1
    } else {
        lastPlayed = 0
    }

    pot1[lastPlayed] = pot2[lastPlayed]
    pot2[lastPlayed] = currentTurn

    currentTurn += 1

    if currentTurn % 1000000 == 0 {
      print("> \(Int(Double(currentTurn) / Double(until) * 100))% calculated")
    }
  }

  return lastPlayed
}

let played = [13, 16, 0, 12, 15, 1]
print("Example 01 Result: \(puzzle(played, until: 2020))")
print("Example 02 Result: \(puzzle(played, until: 30000000))")
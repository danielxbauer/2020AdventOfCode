import Foundation

typealias Seat = (id: Int, row: Int, col: Int)

extension Substring {
  func toBinary(_ zero: String, _ one: String) -> Int {
    let binary = self
      .replacingOccurrences(of: zero, with: "0")
      .replacingOccurrences(of: one, with: "1")
    return Int(binary, radix: 2) ?? -1
  }
}

func day05() {
  let data = readLines(from: "day05/input", ofType: "txt")
  let seats = data.map { (input: String) -> Seat in
    let row = input.prefix(7).toBinary("F", "B")
    let column = input.suffix(3).toBinary("L", "R")
    return (row * 8 + column, row, column)
  }

  // Example 01
  let highestSeat = seats.max { $0.id < $1.id }
  print("Highest seat: \(highestSeat?.id ?? -1)")

  // Example 02
  let seatsSorted = seats.sorted { $0.id < $1.id }
  let previousMissingSeatId = zip(seatsSorted, seatsSorted.dropFirst())
    .filter { ($1.id - $0.id) != 1 }
    .map { (previous, next) in previous.id }
    // Could also write map { $0.0 } but I think that would be confusing
    .first

  let missingSeatId = (previousMissingSeatId ?? -1) + 1
  print("Seat missing: \(missingSeatId)")
}
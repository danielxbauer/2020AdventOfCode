enum Seat: Character {
  case floor = "."
  case empty = "L"
  case occupied = "#"
}

typealias Coord = (x: Int, y: Int)
typealias Delta = (x: Int, y: Int)
typealias DirectionCallback = (Coord, Delta) -> [Seat]

struct Seats: Equatable {
  let width: Int
  let height: Int
  let data: [Seat]

  subscript(index: Int) -> Seat? {
    return data[index]
  }
  subscript(x: Int, y: Int) -> Seat? {
    return x >= 0 && x < height && y >= 0 && y < width 
      ? data[x * width + y] 
      : nil
  }

  func inEveryDirection(from index: Int, _ callback: DirectionCallback) -> [Seat] {
    let x = index / width
    let y = index % width

    var seats: [Seat] = []
    for i in (-1...1) {
      for j in (-1...1) {
        if !(i == 0 && j == 0) {
          seats += callback((x, y), (i, j))
        }
      }
    }

    return seats
  }

  func directNeighbours(_ index: Int) -> [Seat] {
    return inEveryDirection(from: index) { coord, delta in
      let seat = self[coord.x + delta.x, coord.y + delta.y]
      return seat != nil ? [seat!] : []
    }
  }
  func seenNeighbours(_ index: Int) -> [Seat] {
    return inEveryDirection(from: index) { coord, delta in
      var row = coord.x + delta.x
      var col = coord.y + delta.y

      var seats: [Seat] = []
      while let seat = self[row, col] {
        if seat != .floor {
          seats.append(seat)
          break;
        }

        row += delta.x
        col += delta.y
      }

      return seats
    }
  }
}

extension Array where Element == Seat {
  func countOccupied() -> Int {
    return self.filter { $0 == .occupied }.count
  }
}

func rules01(_ seat: Seats) -> Seats {
  let newData = seat.data.enumerated()
    .map { pair -> Seat in
      switch pair.1 {
      case .floor: return .floor
      case .empty: 
        let count = seat.directNeighbours(pair.0).countOccupied()
        return count == 0 ? .occupied : .empty
      case .occupied: 
        let count = seat.directNeighbours(pair.0).countOccupied()
        return count >= 4 ? .empty : .occupied
      }
    }

  return Seats(width: seat.width, height: seat.height, data: newData)
}
func rules02(_ seat: Seats) -> Seats {
  let newData = seat.data.enumerated()
    .map { pair -> Seat in
      switch pair.1 {
      case .floor: return .floor
      case .empty: 
        let count = seat.seenNeighbours(pair.0).countOccupied()
        return count == 0 ? .occupied : .empty
      case .occupied: 
        let count = seat.seenNeighbours(pair.0).countOccupied()
        return count >= 5 ? .empty : .occupied
      }
    }

  return Seats(width: seat.width, height: seat.height, data: newData)
}

func apply(_ initial: Seats, rules: (Seats) -> Seats ) -> Seats {
  var current = initial
  var next = rules(current)

  while current != next {
    current = next
    next = rules(current)
  }

  return current
}

let lines = readLines(from: "input", ofType: "txt")
let height = lines.count
let width = lines.first!.count
let data = lines
  .map { line in line.map { Seat(rawValue: $0) ?? .floor }}
  .flatMap { $0 }

let initialSeats = Seats(width: width, height: height, data: data)

let example01 = apply(initialSeats, rules: rules01)
print("Example 01: Occupied seats: \(example01.data.filter { $0 == .occupied }.count)")

let example02 = apply(initialSeats, rules: rules02)
print("Example 02: Occupied seats: \(example02.data.filter { $0 == .occupied }.count)")

struct Coord: Equatable, Hashable, CustomStringConvertible {
  let x: Int
  let y: Int
  let z: Int

  var description: String {
    return "(\(x) \(y) \(z))"
  }

  func getNeighbours() -> [Coord] {
    var coords: [Coord] = []

    for x in -1...1 {
      for y in -1...1 {
        for z in -1...1 {
          if x == 0 && y == 0 && z == 0 {
            continue // Dont include self
          }

          coords.append(self + Coord(x: x, y: y, z: z))
        }
      }
    }

    return coords
  }

  static func + (rhs: Coord, lhs: Coord) -> Coord {
    return Coord(x: rhs.x + lhs.x, y: rhs.y + lhs.y, z: rhs.z + lhs.z)
  }
}

struct State: Equatable {
  let active: Set<Coord>
  let min: Coord
  let max: Coord
}

let lines = readLines(from: "input", ofType: "txt")

let xCount = lines.first!.count
let yCount = lines.count
print("\(xCount / 2):\(yCount)")

let min: Coord = Coord(
  x: 0 - (xCount / 2),
  y: 0 - (yCount / 2),
  z: 0)

let max = min + Coord(x: xCount, y: yCount, z: 1)

let initialActiveCoords: [Coord] = readLines(from: "input", ofType: "txt")
  .enumerated()
  .map { iLine -> [Coord] in 
    print(iLine)
    return iLine.1.enumerated()
      .filter { _, symbol in symbol == "#" }
      .map { arg -> Coord in
        let (j, _) = arg
        return (Coord(x: iLine.0, y: j, z: 0) + min) 
      } 
  }
  .flatMap { $0 }

let initialState = State(
  active: Set(initialActiveCoords),
  min: min,
  max: max)

func next(_ state: State) -> State {
  var newActiveCoords: [Coord] = []
  let newMin = state.min + Coord(x: -1, y: -1, z: -1)
  let newMax = state.max + Coord(x:  1, y:  1, z:  1)

  for z in newMin.z...newMax.z {
    // print("z = \(z)")

    for x in newMin.x...newMax.x {
      for y in newMin.y...newMax.y {
        let coord = Coord(x: x, y: y, z: z)
        let activeNeighbours = coord.getNeighbours()
          .filter { state.active.contains($0) }
          .count
        
        let oldState = state.active.contains(coord)
        let newState: Bool

        switch (oldState, activeNeighbours) {
        case (true, let count) where count < 2 || count > 3:
          newState = false
        case (false, let count) where count == 3:
          newState = true
        default: 
          newState = oldState
        }
        
        // print("\(x) \(y) [\(oldState ? "#" : ".")]: \(activeNeighbours) -> \(newState ? "#" : ".")")
        if newState {
          newActiveCoords.append(coord)
        }
      }
    }
  }

  return State(active: Set(newActiveCoords),
    min: newMin,
    max: newMax)
}

//let nexState = next(initialState)
//print(nexState.active.count)

var state = initialState
for _ in 1...6 {
  state = next(state)
}

print("Example 01: \(state.active.count)")

// Example 02
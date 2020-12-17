struct Coord: Equatable, Hashable {
  let x: Int
  let y: Int
  let z: Int

  func getNeighbours() -> [Coord] {
    var coords: [Coord] = []

    for x in -1...1 {
      for y in -1...1 {
        for z in -1...1 {
          // Dont include self
          if x == 0 && y == 0 && z == 0 {
            continue 
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

func parseInput() -> State {
  let lines = readLines(from: "input", ofType: "txt")
  let xCount = lines.first!.count
  let yCount = lines.count

  let min = Coord(x: 0 - (xCount / 2), y: 0 - (yCount / 2), z: 0)
  let max = min + Coord(x: xCount, y: yCount, z: 0)
  let active = lines.enumerated()
    .map { i, line in
      return line.enumerated()
        .filter { _, symbol in symbol == "#" }
        .map { j, _ in Coord(x: i, y: j, z: 0) + min } 
    }
    .flatMap { $0 }
  
  return State(active: Set(active), min: min, max: max)
}

func isNowActive(_ state: State, for coord: Coord) -> Bool {
  let activeNeighbours = coord.getNeighbours()
    .filter { state.active.contains($0) }
    .count

  let oldState = state.active.contains(coord)
  switch (oldState, activeNeighbours) {
  case (true, let count) where count < 2 || count > 3:
    return false
  case (false, let count) where count == 3:
    return true
  default: 
    return oldState
  }
}

func next(_ state: State) -> State {
  var newActive: Set<Coord> = []
  let newMin = state.min + Coord(x: -1, y: -1, z: -1)
  let newMax = state.max + Coord(x:  1, y:  1, z:  1)

  for z in newMin.z...newMax.z {
    for x in newMin.x...newMax.x {
      for y in newMin.y...newMax.y {
        let coord = Coord(x: x, y: y, z: z)          
        if isNowActive(state, for: coord) {
          newActive.insert(coord)
        }
      }
    }
  }

  return State(active: newActive, min: newMin, max: newMax)
}

var state = parseInput()
for _ in 1...6 {
  state = next(state)
}

print("Example 01: \(state.active.count)")

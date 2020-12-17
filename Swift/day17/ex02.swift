struct Coord4D: Equatable, Hashable {
  let x: Int
  let y: Int
  let z: Int
  let w: Int

  func getNeighbours() -> [Coord4D] {
    var coords: [Coord4D] = []

    for x in -1...1 {
      for y in -1...1 {
        for z in -1...1 {
          for w in -1...1 {
            // Dont include self:
            if x == 0 && y == 0 && z == 0 && w == 0 {
              continue
            }

            coords.append(self + Coord4D(x: x, y: y, z: z, w: w))
          }
        }
      }
    }

    return coords
  }

  static func + (rhs: Coord4D, lhs: Coord4D) -> Coord4D {
    return Coord4D(
      x: rhs.x + lhs.x, 
      y: rhs.y + lhs.y, 
      z: rhs.z + lhs.z, 
      w: rhs.w + lhs.w)
  }
}

struct State4D: Equatable {
  let active: Set<Coord4D>
  let min: Coord4D
  let max: Coord4D
}

func parseInput() -> State4D {
  let lines = readLines(from: "input", ofType: "txt")
  let xCount = lines.first!.count
  let yCount = lines.count

  let min = Coord4D(x: 0 - (xCount / 2), y: 0 - (yCount / 2), z: 0, w: 0)
  let max = min + Coord4D(x: xCount, y: yCount, z: 0, w: 0)
  let active = lines.enumerated()
    .map { i, line in
      return line.enumerated()
        .filter { _, symbol in symbol == "#" }
        .map { j, _ in Coord4D(x: i, y: j, z: 0, w: 0) + min } 
    }
    .flatMap { $0 }
  
  return State4D(active: Set(active), min: min, max: max)
}

func isNowActive(_ state: State4D, for coord: Coord4D) -> Bool {
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

func next(_ state: State4D) -> State4D {
  var newActive: Set<Coord4D> = []
  let newMin = state.min + Coord4D(x: -1, y: -1, z: -1, w: -1)
  let newMax = state.max + Coord4D(x:  1, y:  1, z:  1, w:  1)

  for z in newMin.z...newMax.z {
    for x in newMin.x...newMax.x {
      for y in newMin.y...newMax.y {
        for w in newMin.w...newMax.w {
          let coord = Coord4D(x: x, y: y, z: z, w: w)          
          if isNowActive(state, for: coord) {
            newActive.insert(coord)
          }
        }
      }
    }
  }

  return State4D(active: newActive, min: newMin, max: newMax)
}

var state = parseInput()
for _ in 1...6 {
  state = next(state)
}

print("Example 02: \(state.active.count)")

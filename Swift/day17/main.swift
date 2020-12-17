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
            if x == 0 && y == 0 && z == 0 && w == 0 {
              continue // Dont include self
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

let lines = readLines(from: "input", ofType: "txt")

let xCount = lines.first!.count
let yCount = lines.count
print("\(xCount / 2):\(yCount)")

let min = Coord4D(
  x: 0 - (xCount / 2),
  y: 0 - (yCount / 2),
  z: 0,
  w: 0)

let max = min + Coord4D(x: xCount, y: yCount, z: 0, w: 0)

let initialActiveCoords: [Coord4D] = readLines(from: "input", ofType: "txt")
  .enumerated()
  .map { iLine -> [Coord4D] in 
    print(iLine)
    return iLine.1.enumerated()
      .filter { _, symbol in symbol == "#" }
      .map { arg -> Coord4D in
        let (j, _) = arg
        return (Coord4D(x: iLine.0, y: j, z: 0, w: 0) + min) 
      } 
  }
  .flatMap { $0 }

let initialState = State4D(
  active: Set(initialActiveCoords),
  min: min,
  max: max)

func next(_ state: State4D) -> State4D {
  var newActiveCoords: [Coord4D] = []
  let newMin = state.min + Coord4D(x: -1, y: -1, z: -1, w: -1)
  let newMax = state.max + Coord4D(x:  1, y:  1, z:  1, w:  1)

  for z in newMin.z...newMax.z {
    // print("z = \(z)")

    for x in newMin.x...newMax.x {
      for y in newMin.y...newMax.y {
        for w in newMin.w...newMax.w {
          let coord = Coord4D(x: x, y: y, z: z, w: w)
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
  }

  return State4D(active: Set(newActiveCoords),
    min: newMin,
    max: newMax)
}

//let nexState = next(initialState)
//print(nexState.active.count)

var state = initialState
for _ in 1...6 {
  state = next(state)
}

print("Example 02: \(state.active.count)")

// Example 02
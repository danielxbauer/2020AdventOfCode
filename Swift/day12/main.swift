import Foundation

struct Coord: Equatable, CustomStringConvertible {
  let x: Double
  let y: Double

  var length: Double {
    return abs(x) + abs(y)
  }
  var description: String {
    return "(\(Int(x)), \(Int(y)))"
  }

  func turn(_ degree: Double) -> Coord {
    let value = degree * Double.pi / 180.0
    return Coord(
      x: x * cos(value) - y * sin(value),
      y: x * sin(value) + y * cos(value))
  }

  static func + (lhs: Coord, rhs: Coord) -> Coord {
    return Coord(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }

  static func * (lhs: Coord, rhs: Double) -> Coord {
    return Coord(x: lhs.x * rhs, y: lhs.y * rhs)
  }
}

let east = Coord(x: 0, y: 1)
let west = Coord(x: 0, y: -1)
let south = Coord(x: 1, y: 0)
let north = Coord(x: -1, y: 0)

func read() -> [(String, Double)] {
  return readLines(from: "input", ofType: "txt")
    .map { line in
      let input = String(line.prefix(1))
      let value = Double(line.dropFirst()) ?? 0.0
      return (input, value)
    }
}

func steer(from ship: Coord, looking direction: Coord) -> Coord {
  var ship = ship
  var direction = direction
  for (input, value) in read() {
    switch input {
      case "N": ship = ship + north * value
      case "S": ship = ship + south * value
      case "W": ship = ship + west * value
      case "E": ship = ship + east * value
      case "F": ship = ship + direction * value
      case "R": direction = direction.turn(value * -1)
      case "L": direction = direction.turn(value)
      default: print("ERROR")
    }
  }

  return ship
}

func steer(from ship: Coord, waypoint: Coord) -> Coord {
  var ship = ship
  var waypoint = waypoint
  for (input, value) in read() {    
    switch input {
      case "N": waypoint = waypoint + north * value
      case "S": waypoint = waypoint + south * value
      case "W": waypoint = waypoint + west * value
      case "E": waypoint = waypoint + east * value
      case "F": ship = ship + waypoint * value
      case "R": waypoint = waypoint.turn(value * -1)
      case "L": waypoint = waypoint.turn(value)
      default: print("ERROR")
    }
  }

  return ship
}

print("Example 01")
let ship = steer(from: Coord(x: 0, y: 0), looking: east)
print("Ship is at: \(ship) with distance: \(Int(ship.length))")

print("\nExample 02")
let ship2 = steer(from: Coord(x: 0, y: 0), waypoint: Coord(x: -1, y: 10))
print("Ship is at: \(ship2) with distance: \(Int(ship2.length))")
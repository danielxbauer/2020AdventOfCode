import Foundation

typealias Color = String
typealias Bag = (color: Color, bags: [Color:Int])
typealias Bags = [Color: [Color: Int]]

func parseBag(from input: String) -> Bag {
  let color = input.matches(for: "([\\w]+ [\\w]+) bags contain")[0][1]
  let bags = input.matches(for: "(([1-9]+) (([\\w]+ [\\w]+)) bag)")
    .reduce(into: [:]) { result, next in
      result[next[3]] = Int(next[2]) ?? 0
    }

  return (color, bags)
}

let bags: Bags = readLines(from: "input", ofType: "txt")
  .map { parseBag(from: $0) }
  .reduce(into: [:]) { all, bag in
    all[bag.color] = bag.bags
  }

// Example 01
func contains(_ color: Color, in bagColor: Color, all bags: Bags) -> Bool {
  let bag = bags[bagColor] ?? [:]
  return bag[color] != nil
      || bag.first { contains(color, in: $0.0, all: bags) } != nil
}

let shinyBagsCount = bags
  .map { contains("shiny gold", in: $0.0, all: bags)}
  .filter { $0 }
  .count

print("Count of shiny bags: \(shinyBagsCount)")

// Example 02
func count(_ color: Color, in bags: Bags) -> Int {
  return (bags[color] ?? [:])
    .map { $0.1 + $0.1 * count($0.0, in: bags) }
    .reduce(0, +)
}

let bagsNeeded = count("shiny gold", in: bags)
print("Bags needed: \(bagsNeeded)")
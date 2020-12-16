import Foundation

struct Ticket {
  let numbers: [Int]
}

struct Rule {
  let name: String
  let ranges: [Int]

  func validate(_ value: Int) -> Bool {
    return (value >= ranges[0] && value <= ranges[1])
        || (value >= ranges[2] && value <= ranges[3])
  }
}

extension Array where Element == Rule {
  func isInvalid(_ number: Int) -> Bool {
    return self.map { $0.validate(number) }.firstIndex(of: true) == nil
  }
}

func parseTicket(_ string: String) -> Ticket {
  let numbers = string.components(separatedBy: ",")
    .map { Int($0) }
    .compactMap { $0 }

  return Ticket(numbers: numbers)
}

// 0. Parse Input
let input = readContent(from: "input", ofType: "txt")
  .components(separatedBy: "\n\n")

let rules: [Rule] = input[0].components(separatedBy: "\n")
  .map { line in
    let name = line.matches(for: "([\\w ]+):")[0][1]
    let ranges = line.matches(for: "(\\d+)-(\\d+) or (\\d+)-(\\d+)")[0]
      .map { Int($0) }
      .compactMap { $0 }

    return Rule(name: name, ranges: ranges)
  }

let tickets: [Ticket] = input[2]
  .components(separatedBy: "\n")
  .dropFirst() // Kick out headline
  .map { parseTicket($0) }

let ownTicket = parseTicket(input[1].components(separatedBy: "\n").last!)

// Example 01
var validTickets: [Ticket] = []
var sumInvalidTickets = 0
for ticket in tickets {
  var isInvalid = false
  for number in ticket.numbers {
    if rules.isInvalid(number) {
      isInvalid = true
      sumInvalidTickets += number
    }
  }

  if !isInvalid {
    validTickets.append(ticket)
  }
}

print("Example 01: \(sumInvalidTickets)")

// Example 02
let ruleMatches: [String: [Int]] = rules
  .reduce(into: [:]) { ruleMatches, rule in
    let matches: [Int] = (0..<rules.count)
      .reduce(into: []) { result, i in 
        let valid = validTickets
          .map { rule.validate($0.numbers[i]) }
          .firstIndex(of: false) == nil

        if valid {
          result.append(i)
        }
      }
    
    ruleMatches[rule.name] = matches
  }

var ruleTaken: [String: Int] = [:]
for (key, value) in (ruleMatches.sorted { $0.value.count < $1.value.count }) {
  ruleTaken[key] = value.filter { !ruleTaken.values.contains($0) }.first
}

let result = ruleTaken
  .filter { key, value in key.starts(with: "departure")}
  .map { key, value in ownTicket.numbers[value] }
  .reduce(1, *)

print("Example 02: \(result)")

import Foundation

extension Array where Element == String {
  func toMap(separatedBy str: String) -> [String: String] {
      return self.reduce(into: [:]) { result, next in
          let pair = next.components(separatedBy: str)
          result[pair[0]] = pair[1]
      }
  }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

typealias Passport = [String: String]

func day04() {
  let requiredFields: Set = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
  let passports: [Passport] = readContent(from: "day04/input", ofType: "txt")
    .components(separatedBy: "\n\n")
    .map { $0
      .replacingOccurrences(of: "\n", with: " ")
      .components(separatedBy: " ")
      .toMap(separatedBy: ":")
    }

  // Example 01
  let validPassports = passports
    .filter { requiredFields.isSubset(of: $0.keys) }
    .count

  print("Valid passports 01: \(validPassports)")

  // Example 02
  let validPassports2 = passports
    .filter { requiredFields.isSubset(of: $0.keys) }
    .map { passport in
      passport.map { pair -> Bool in
        switch pair.key {
        case "byr": return (1920...2002).contains(Int(pair.value) ?? -1)
        case "iyr": return (2010...2020).contains(Int(pair.value) ?? -1)
        case "eyr": return (2020...2030).contains(Int(pair.value) ?? -1)
        case "hcl": return pair.value.matches("#[a-f0-9]{6}")
        case "pid": return pair.value.length == 9 && pair.value.matches("[0-9]{9}")
        case "ecl": return Set(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]).contains(pair.value)
        case "hgt":
          switch pair.value.suffix(2) {
          case "cm": return (150...193).contains(Int(pair.value.dropLast(2)) ?? -1)
          case "in": return (59...76).contains(Int(pair.value.dropLast(2)) ?? -1)
          default: return false
          }
        default: return true
        }
      }
    }
    .filter { !$0.contains(false) }
    .count

  print("Valid passports 02: \(validPassports2)")
}
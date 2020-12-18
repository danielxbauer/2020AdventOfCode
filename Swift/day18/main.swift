// Example 02
infix operator ++: MultiplicationPrecedence // : MultiplicationPrecedence
infix operator **: AdditionPrecedence // : AdditionPrecedence

extension Int {
  static func ++ (r: Int, l: Int) -> Int { return r + l }
  static func ** (r: Int, l: Int) -> Int { return r * l }
}

// TODO: Currently not supported in Linux Swift
/*let mathExpression = NSExpression(format: "4 + 5 - 2 * 3")
let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Int
*/

// TODO:
// readLines()
//  .map { line in 
      // let s = line.replaceOccurancesOf("+", "++")
      //   .replaceOccurancesOf("*", "**")

      // return  NSExpression(format: "4 + 5 - 2 * 3").expressionValue(with: nil, context: nil) as? Int
// }

// print("Ex02: \(input.reduce(0, +))")
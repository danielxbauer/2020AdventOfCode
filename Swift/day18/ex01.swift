import Foundation

// func parse(_ termStr: String) -> (Int, Part)? {
//   var op: Op?
//   var nums: [Part] = []
  
//   // print("Parsing: \(termStr)")

//   var i = 0
//   while i < termStr.count {
//     let partStr = termStr[i]

//     // print("PARSE: \(i) \(partStr)")

//     if let newOp = Op(rawValue: partStr) {
//       if let op = op {
//         nums = [Part.eval(op, nums)]
//       }

//       op = newOp
//     }    
//     else if let value = Int(partStr) {
//       nums.append(Part.num(value))
//     }
//     else if partStr == "(" {
//       // let j = termStr.dropFirst(i + 1).lastIndex(of: ")") ?? termStr.endIndex
//       //let subPart = Array(termStr[(i + 1)...(j-1)])*/
//       let subPart = termStr.substring(fromIndex: i + 1)
//       // print("SUBPART: \(subPart)")
//       if let sub = parse(subPart) {
//         nums.append(sub.1)
//         i += sub.0
//       }
//     } else if partStr == ")" {
//       if let op = op {   
//         // print("SUBPART END: \(i)")     
//         return (i + 1, Part.eval(op, nums))
//       } else {
//         return nil
//       }
//     }

//     i += 1
//   }

//   if let op = op {
//     return (termStr.count, Part.eval(op, nums))
//   } else {
//     return nil
//   }
// }

// let sum = readLines(from: "input", ofType: "txt")
//   .map { parse($0) }
//   .compactMap { $0 }
//   .map { $0.1.calculate() }
//   .reduce(0, +)

// print("Example 01: \(sum)")

// typealias Result = (acc: Int, fun: (Int, Int) -> Int)
// func reduceMe(_ i: inout Int, _ count: Int, _ term: inout String) -> Result {
//   print("REDUCE ME: [\(term)]")
//   var state: Result = (acc: 0, fun: +)
//   // var i = 0
//   while i < count  {
//     // let char = String(term[i])
//     let char = String(term.remove(at: term.startIndex))
//     i += 1
//     if char == " " { continue }

//     print("\(char): [\(term)]")
//     switch char {
//     case "+": state = (acc: state.acc, fun: +)
//     case "*": state = (acc: state.acc, fun: *)
//     case "(": 
//       let subState = reduceMe(&i, count, &term)
//       print("SUBSTATE: \(subState)")
//       state.acc = state.fun(state.acc, subState.acc)
//     case ")":
//       return state
//     default:
//       if let value = Int(char) {
//         state.acc = state.fun(state.acc, value) 
//       }
//     }
//   }

//   return state
// }

// print("EXPERIMENT")

// var i = 0
// var term = "1 + (2 * 3) + (4 * (5 + 6))"
// print(reduceMe(&i, term.count, &term))




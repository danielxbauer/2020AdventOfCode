import Foundation

func readContent(from: String, ofType: String) -> String {
  let path = Bundle.main.path(forResource: from, ofType: ofType)
  return try! String(contentsOfFile: path!, encoding: .utf8)
}

func readLines(from: String, ofType: String) -> [String] {
  return readContent(from: from, ofType: ofType)
    .components(separatedBy: "\n")
}

extension String {
  func leftPad(to length: Int, with pad: Character) -> String {
    return self.count < length
      ? String(repeating: pad, count: length - self.count) + self
      : String(self.suffix(length))
  }

  func matches(for regex: String) -> [[String]] {
      guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
      let nsString = self as NSString
      let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
      return results.map { result in
          (0..<result.numberOfRanges).map {
              result.range(at: $0).location != NSNotFound
                  ? nsString.substring(with: result.range(at: $0))
                  : ""
          }
      }
  }

  func index(offsetBy value: String.IndexDistance) -> String.Index {
    return self.index(self.startIndex, offsetBy: value)
  }
}

// https://stackoverflow.com/a/26775912/2391070
extension String {
    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
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
}
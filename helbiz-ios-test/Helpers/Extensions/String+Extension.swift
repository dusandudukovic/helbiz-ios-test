//
//  String+Extension.swift
//

import Foundation

extension String {
    
    func asNoteText() -> String {
        if count > 16 {
            var new = String(self[0...12])
            new += "..."
            return new
        }
        return self
    }
    
    func removeNewLines() -> String {
        return components(separatedBy: .newlines).joined()
    }
    
    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespacesAndNewlines).joined()
    }
    
    func removeLetters() -> String {
        return components(separatedBy: .letters).joined()
    }
    
    func asPhoneString() -> String {
        let text = removeWhitespaces().removeLetters()
        return text.components(separatedBy: .punctuationCharacters).joined()
    }
    
    func toDateFromBackend() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: self)
        return date
    }
    
    func toDate2FromBackend() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: self)
        return date
    }
    
    func timeStringToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 7200)
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let date = formatter.date(from: self)
        return date
    }
    
    func toPriceDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        let text = self.replacingOccurrences(of: "RSD", with: "")
            .replacingOccurrences(of: "EUR", with: "")
            .replacingOccurrences(of: "USD", with: "")
            .replacingOccurrences(of: "$", with: "")
            .removeLetters()
            .removeNewLines()
            .removeWhitespaces()
        
        if let result = formatter.number(from: text) {
            return Double(exactly: result)
        } else {
            return nil
        }
    }
    
}

extension String {
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}


extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    func maskCreditCardNumber() -> String {
        let regex = #".*(\d{4})"#
        let mask = "**** **** **** $1"

        return self.replacingOccurrences(of: regex, with: mask, options: .regularExpression)
    }
    
    func formatCreditCardNumber() -> String {
        let regex = #"(\d{4})(\d{4})(\d{4})(\d{4})"#
        let mask = "$1 $2 $3 $4"

        return self.replacingOccurrences(of: regex, with: mask, options: .regularExpression)
    }
    
    func maskCVVNumber() -> String {
        let mask = "***"
        return mask
    }
}
public extension String {
    subscript(value: Int) -> Character {
        self[index(at: value)]
    }
}

public extension String {
    subscript(value: NSRange) -> Substring {
        self[value.lowerBound..<value.upperBound]
    }
}

public extension String {
    subscript(value: CountableClosedRange<Int>) -> Substring {
        self[index(at: value.lowerBound)...index(at: value.upperBound)]
    }
    
    subscript(value: CountableRange<Int>) -> Substring {
        self[index(at: value.lowerBound)..<index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        self[..<index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        self[...index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        self[index(at: value.lowerBound)...]
    }
}

private extension String {
    func index(at offset: Int) -> String.Index {
        index(startIndex, offsetBy: offset)
    }
}

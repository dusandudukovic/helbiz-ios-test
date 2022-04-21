//
//  Date+Extension.swift
//

import Foundation

extension Date {
    
    func toYMDString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let string = formatter.string(from: self)
        return string
    }
    
    func toBackendString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let string = formatter.string(from: self)
        return string
    }
    
    func toTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YY hh:mm"
        let string = formatter.string(from: self)
        return string
    }
    
    func toMMYYDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/YY"
        let string = formatter.string(from: self)
        return string
    }
    
    func toYYMMDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        let string = formatter.string(from: self)
        return string
    }
    
    func toWeekday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        let string = formatter.string(from: self)
        return string.uppercased()
    }
    
    func toDayInMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let string = formatter.string(from: self)
        return string
    }
    
    static func oneWeekAgo() -> Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date(timeIntervalSinceNow: -604800)
    }
    
    static func oneMonthAgo() -> Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date(timeIntervalSinceNow: -2592000)
    }
    
    static func minimumDate() -> Date {
        return Date(timeIntervalSince1970: 0.00)
    }
    
    func lastDayOfMonth() -> Date? {
        let calendar = NSCalendar.current
        let dayRange = calendar.range(of: .day, in: .month, for: self)
        let dayCount = dayRange?.count
        var comp = calendar.dateComponents([.year, .month, .day], from: self)

        comp.day = dayCount

        return calendar.date(from: comp)
    }
}

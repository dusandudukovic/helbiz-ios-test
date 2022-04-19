//
//  Double+Extension.swift
//

import Foundation

extension Double {
    
    func toPriceString() -> String? {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        formatter.groupingSize = 3
        
        return formatter.string(from: number)
    }
    
}

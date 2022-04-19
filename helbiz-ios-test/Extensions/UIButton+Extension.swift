//
//  UIButton+Extension.swift
//

import UIKit

extension UIButton {
    func selectAndAddBorder() {
        borderWidth = 1
        borderColor = .black
        isSelected = true
    }
    
    func deselectAndRemoveBorder() {
        borderColor = .gray
        isSelected = false
    }
}

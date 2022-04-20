//
//  Styles.swift
//  StarterTemplate-core
//
//  Created by Dusan on 14.3.22..
//

import UIKit

struct Style {
    
    private var mainFontString = "Futura-Medium"
    private var mainBoldFontString = "Futura-Bold"
    
    var regularSize: CGFloat = 14
    var mediumSize: CGFloat = 15
    var largeSize: CGFloat = 16
    
    var textColor: UIColor = .white
    var backgroundColor: UIColor = UIColor(red: 36, green: 47, blue: 62, alpha: 1)
    var secondaryColorLight: UIColor = UIColor(red: 56, green: 65, blue: 78, alpha: 1)
    var secondaryColorDark: UIColor = UIColor(red: 18, green: 23, blue: 31, alpha: 1)
    var actionColor: UIColor = UIColor(red: 173, green: 128, blue: 54, alpha: 1)
    
    func mainRegularFont(_ size: CGFloat? = nil) -> UIFont {
        return UIFont(name: mainFontString, size: size ?? regularSize)!
    }
    
    func mainMediumFont(_ size: CGFloat? = nil) -> UIFont {
        return UIFont(name: mainFontString, size: size ?? regularSize)!
    }
    
    func mainBoldFont(_ size: CGFloat? = nil) -> UIFont {
        return UIFont(name: mainBoldFontString, size: size ?? regularSize)!
    }
    
    
}

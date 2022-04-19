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

//
//  Styles.swift
//  StarterTemplate-core
//
//  Created by Dusan on 14.3.22..
//

import UIKit

struct Style {
    
    private var mainFontString = "HelveticaNeue"
    private var mainBoldFontString = "HelveticaNeue-Bold"
    
    var regularSize: CGFloat = 14
    var mediumSize: CGFloat = 15
    var largeSize: CGFloat = 16
    
    var textColor: UIColor = .white
    var backgroundColor: UIColor = UIColor(red: 36/255, green: 47/255, blue: 62/255, alpha: 1)
    var secondaryColorLight: UIColor = UIColor(red: 56/255, green: 65/255, blue: 78/255, alpha: 1)
    var secondaryColorDark: UIColor = UIColor(red: 18/255, green: 23/255, blue: 31/255, alpha: 1)
    var actionColor: UIColor = UIColor(named: "Action")!
    
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

//
//  UICollectionViewCell+Extension.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

}

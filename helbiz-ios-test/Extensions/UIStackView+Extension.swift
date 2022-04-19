//
//  UIStackView+Extension.swift
//

import UIKit

extension UIStackView {

    func empty() {
        self.subviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
}

//
//  CALayer+Extension.swift
//

import UIKit

extension CALayer {
    
    func bounceOnce(duration: CFTimeInterval, scale: CGFloat) {
        let animationX = CABasicAnimation(keyPath: "transform.scale")
        animationX.duration = duration
        animationX.fromValue = 1
        animationX.toValue = scale
        animationX.autoreverses = true
        animationX.repeatCount = 1
        animationX.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        add(animationX, forKey: "animateScaleX")
    }
    
}

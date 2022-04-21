//
//  UIView + Extension.swift
//

import Foundation
import UIKit

/// Protocol to be extended with implementations
protocol UIViewLoading {}

extension UIView: UIViewLoading {
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            } else {
                return nil
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    func setCornerRadius(_ radius: CGFloat, maskedCornes: CACornerMask) {
        layer.maskedCorners = maskedCornes
        layer.cornerRadius = radius
        clipsToBounds = radius > 0
    }
    
    func bounceOnce(duration: CFTimeInterval, scale: CGFloat) {
        layer.bounceOnce(duration: duration, scale: scale)
    }
    
    func applyShadow(withRadius radius: CGFloat, forOpacity opacity: Float) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = radius
    }
    
    func addShadow(color: UIColor = UIColor.black, offset: CGSize = CGSize(width: 0, height: 2), radius: CGFloat = 10, opacity: Float = 0.1) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    @objc
    func isEnabled(_ bool: Bool) {
        if isUserInteractionEnabled == bool {
            return
        }
        isUserInteractionEnabled = bool
        alpha = bool ? 1 : 0.5
    }
    
    var textViewsInView: [UITextView] {
        return subviews
            .filter ({ !($0 is UITextView) })
            .reduce (( subviews.compactMap { $0 as? UITextView }), { summ, current in
                return summ + current.textViewsInView
            })
    }
    var textFieldsInView: [UITextField] {
        return subviews
            .filter ({ !($0 is UITextField) })
            .reduce (( subviews.compactMap { $0 as? UITextField }), { summ, current in
                return summ + current.textFieldsInView
            })
    }
    var selectedTextView: UITextView? {
        return textViewsInView.filter { $0.isFirstResponder }.first
    }
    var selectedTextField: UITextField? {
        return textFieldsInView.filter { $0.isFirstResponder }.first
    }
    
    func addDashedBorder() {
        let color = UIColor.dashedBorderColor.cgColor
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 1, y: 1, width: frameSize.width - 1, height: frameSize.height - 1)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
}

/// Protocol implementation
extension UIViewLoading where Self : UIView {
    /**
     Creates a new instance of the class on which this method is invoked,
     instantiated from a nib of the given name. If no nib name is given
     then a nib with the name of the class is used.
     
     - parameter nibNameOrNil: The name of the nib to instantiate from, or
     nil to indicate the nib with the name of the class should be used.
     
     - returns: A new instance of the class, loaded from a nib.
     */
    static func loadFromNib(nibNameOrNil: String? = nil) -> Self? {
        let nibName = nibNameOrNil ?? self.className
        return Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? Self
    }
    
    private static var className: String {
        return "\(self)"
    }
    
}

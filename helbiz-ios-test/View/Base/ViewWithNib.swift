//
//  ViewWithNib.swift
//  StarterTemplate-core
//
//  Created by Dusan on 23.2.22..
//

import Foundation
import UIKit

public class ViewWithNib: UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        NibSupport.setupNib(view: self)
        didInitNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        NibSupport.setupNib(view: self)
        didInitNib()
    }
    
    func didInitNib() {
        
    }
}

public class TableViewCellWithNib: UITableViewCell {
    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        NibSupport.setupNib(view: self)
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        NibSupport.setupNib(view: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        NibSupport.setupNib(view: self)
    }
    
}

public class CollectionViewCellWithNib: UICollectionViewCell {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        NibSupport.setupNib(view: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        NibSupport.setupNib(view: self)
    }
    
}

public class CollectionReusableViewWithNib: UICollectionReusableView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        NibSupport.setupNib(view: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        NibSupport.setupNib(view: self)
    }
    
}

private class NibSupport {
    
    static func setupNib(view: UIView) {
        let childView = self.loadNib(view: view)
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        if view is UITableViewCell {
            addChildViewWithConstraints(view: (view as! UITableViewCell).contentView, childView: childView)
        } else {
            addChildViewWithConstraints(view: view, childView: childView)
        }
    }
    
    private static func addChildViewWithConstraints(view: UIView, childView: UIView) {
        view.addSubview(childView)
        
        constraint(view, child:childView, attribute:.width)
        constraint(view, child:childView, attribute:.height)
        constraint(view, child:childView, attribute:.top)
        constraint(view, child:childView, attribute:.leading)
    }
    
    private static func constraint(_ view: UIView, child: UIView, attribute: NSLayoutConstraint.Attribute) -> Void {
        let constraint = NSLayoutConstraint(
            item: child,
            attribute: attribute,
            relatedBy: .equal,
            toItem: view,
            attribute: attribute,
            multiplier: 1.0,
            constant: 0)
        
        view.addConstraint(constraint)
    }
    
    private static func loadNib(view: UIView) -> UIView {
        let bundle = Bundle(for: type(of: view))
        
        let nib = UINib(nibName: nibName(view), bundle: bundle)
        return nib.instantiate(withOwner: view, options: nil)[0] as! UIView
    }
    
    private static func nibName(_ view: UIView) -> String {
        return type(of: view).description().components(separatedBy: ".").last!
    }
}

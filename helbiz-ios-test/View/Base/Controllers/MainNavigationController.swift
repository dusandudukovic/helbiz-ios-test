//
//  MainNavigationController.swift
//  StarterTemplate-core
//
//  Created by Dusan on 23.2.22..
//

import UIKit

class MainNaviationController: UINavigationController {
    
    var style: Style?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = style?.backgroundColor
        
        setNavigationBarHidden(true, animated: false)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = style?.backgroundColor
        appearance.shadowColor = UIColor.clear
        
        navigationBar.standardAppearance = appearance
        navigationBar.tintColor = .white
        
        if let style = style {
            appearance.titleTextAttributes = [.font: style.mainBoldFont(), NSAttributedString.Key.foregroundColor: UIColor.black]
            // bar buttons
            UIBarButtonItem.appearance().setTitleTextAttributes([.font: style.mainRegularFont()], for: .normal)
        }
        
    }
    
}

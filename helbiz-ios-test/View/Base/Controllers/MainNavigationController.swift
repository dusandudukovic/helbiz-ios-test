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
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundColor
        appearance.shadowColor = UIColor.clear
        
        navigationBar.standardAppearance = appearance
        
        if let style = style {
            appearance.titleTextAttributes = [.font: style.mainBoldFont(), NSAttributedString.Key.foregroundColor: UIColor.black]
            // bar buttons
            UIBarButtonItem.appearance().setTitleTextAttributes([.font: style.mainRegularFont()], for: .normal)
        }
        
    }
    
}

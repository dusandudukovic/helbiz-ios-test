//
//  ModalNavigationController.swift
//  StarterTemplate-core
//
//  Created by Dusan on 23.2.22..
//

import UIKit

class ModalNavigationController: UINavigationController {
    
    var style: Style?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        modalPresentationCapturesStatusBarAppearance = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundColor
        appearance.shadowColor = UIColor.clear
        
        if let style = style {
            appearance.titleTextAttributes = [.font: style.mainBoldFont(16), NSAttributedString.Key.foregroundColor: UIColor.black]
            // bar buttons
            UIBarButtonItem.appearance().setTitleTextAttributes([.font: style.mainRegularFont(16)], for: .normal)
        }
        
        navigationBar.standardAppearance = appearance
    }
    
}

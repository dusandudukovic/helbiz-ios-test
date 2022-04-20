//
//  HomeViewController.swift
//  StarterTemplate-core
//
//  Created by Dusan on 14.3.22..
//

import UIKit

class HomeViewController: BaseViewController {
    
    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        presenter?.startTracking()
    }

    func setup() {
        presenter?.authorizationIsDenied = { [weak self] in
            guard let `self` = self else { return }
            self.showAlert(title: "Tracking not allowed",
                           message: "Please allow sharing device location in Settings to use this app.",
                           buttonTitle: "Go to Settings", showCancel: true) { action in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }
        }
    }
    
}

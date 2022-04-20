//
//  HomeViewController.swift
//  StarterTemplate-core
//
//  Created by Dusan on 14.3.22..
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var mapView: MapView!
    
    var style: Style?
    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        presenter?.startTracking()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView.moveCameraToUser()
    }

    func setup() {
        presenter?.authorizationGranted = { [weak self] bool in
            guard let `self` = self else { return }
            if bool {
                self.mapView.moveCameraToUser()
            } else {
                self.showAlert(title: "Tracking not allowed",
                               message: "Please allow sharing device location in Settings to use this app.",
                               buttonTitle: "Go to Settings", showCancel: true) { action in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
            }
        }
    }
}

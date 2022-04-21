//
//  FoodPlacesViewController.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation

class FoodPlacesViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MapView!
    
    var style: Style?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView.moveCameraToUser()
    }

    func setup() {
        
    }
}


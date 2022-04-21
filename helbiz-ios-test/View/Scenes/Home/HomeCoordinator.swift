//
//  HomeCoordinator.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    
    enum Destination {
        case PoiDetails(poi: Poi)
    }
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    required init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func navigate(to destination: Destination) {
        switch destination {
        case .PoiDetails(let poi):
            navigationController.pushViewController(factory.poiDetailsViewController(poi: poi), animated: true)
        }
    }
}

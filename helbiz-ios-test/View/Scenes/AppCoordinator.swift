//
//  AppCoordinator.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    enum Destination {
        case Home
    }
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    required init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func navigate(to destination: Destination) {
        switch destination {
        case .Home:
            navigationController.pushViewController(factory.homeViewController(), animated: false)
        }
    }
    
}

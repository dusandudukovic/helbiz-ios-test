//
//  Coordinator.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import UIKit

protocol Coordinator: AnyObject {
    associatedtype Destination
    
    init(navigationController: UINavigationController, factory: ViewControllerFactory)
    
    func navigate(to destination: Destination)
}

protocol ModalCoordinator: AnyObject {
    associatedtype Destination
    
    init(factory: ViewControllerFactory)
    
    func navigate(to destination: Destination)
}

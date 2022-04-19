//
//  DependencyContainer.swift
//  StarterTemplate-core
//
//  Created by Dusan on 23.2.22..
//

import Foundation
import Alamofire
import UIKit

class DependencyContainer {
    
    // MARK: - Global dependencies
    
    lazy var navigationController: MainNaviationController = {
        let nav = MainNaviationController()
        nav.style = style
        return nav
    }()
    
    private lazy var fileManager: FileManager = {
        return FileManager.default
    }()
    
    private lazy var defaultHeaders: HTTPHeaders = {
        return HTTPHeaders.default
    }()
    
    private lazy var session: Session = {
        return Session()
    }()
    
    lazy var appSession: AppSession = {
        return AppSession()
    }()
    
    private lazy var tokenManager: TokenManager = {
       return TokenManager(headers: defaultHeaders, appSession: appSession)
    }()
    
    lazy var style: Style = {
        return Style()
    }()
    
    private lazy var defaultRequestHandler: DataRequestHandler = {
        return DefaultDataRequestHandler()
    }()

//    func makeValidationService() -> ValidationService {
//        return ValidationService()
//    }
    
}

// MARK: - ViewController Factory

extension DependencyContainer: ViewControllerFactory {
    func homeViewController() -> BaseViewController {
        if let vc = UIStoryboard(name: "Home", bundle: .none).instantiateInitialViewController() as? HomeViewController {
            vc.presenter = homePresenter()
            return vc
        }
        fatalError("Failed to load ViewController from Storyboard")
    }
}

// MARK: - Coordinator Factory

extension DependencyContainer: CoordinatorFactory {
    
}

// MARK: - Presenter Factory

extension DependencyContainer: PresenterFactory {
    func homePresenter() -> HomePresenter {
        return HomePresenter()
    }
}

// MARK: - UseCase Factory

extension DependencyContainer: UseCaseFactory {
    
}

// MARK: - NetworkService Factory

extension DependencyContainer: NetworkServiceFactory {
    
}

// MARK: - Service Factory

extension DependencyContainer: ServiceFactory {
    
}


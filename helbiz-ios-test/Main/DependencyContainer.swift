//
//  DependencyContainer.swift
//  StarterTemplate-core
//
//  Created by Dusan on 23.2.22..
//

import Foundation
import Alamofire
import UIKit
import CoreLocation

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
        var headers = HTTPHeaders.default
        headers.add(name: "X-Triposo-Account", value: tokens.triposoAccount)
        headers.add(name: "X-Triposo-Token", value: tokens.triposoToken)
        return headers
    }()
    
    private lazy var session: Session = {
        return Session()
    }()
    
    lazy var appSession: AppSession = {
        return AppSession()
    }()
    
    lazy var style: Style = {
        return Style()
    }()
    
    lazy var tokens: RequestTokens = {
        return RequestTokens()
    }()
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.pausesLocationUpdatesAutomatically = false
        lm.activityType = .fitness
        lm.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return lm
    }()
    
    lazy var locationService: LocationService = {
       return LocationService(appSession: appSession, locationManager: locationManager)
    }()
    
    private lazy var tokenManager: TokenManager = {
       return TokenManager(headers: defaultHeaders, appSession: appSession)
    }()
    
    private lazy var defaultRequestHandler: DataRequestHandler = {
        return DefaultDataRequestHandler()
    }()
    
}

// MARK: - ViewController Factory

extension DependencyContainer: ViewControllerFactory {
    func homeViewController() -> BaseViewController {
        if let vc = UIStoryboard(name: "Home", bundle: .none).instantiateInitialViewController() as? HomeViewController {
            vc.presenter = homePresenter()
            vc.style = style
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
        return HomePresenter(locationService: locationService,
                             getPOIsUseCase: getPOIsUseCase(), getTagsUseCase: getTagsUseCase(),
                             tagsViewModel: TagsViewModel(), poisViewModel: PoisViewModel())
    }
}

// MARK: - UseCase Factory

extension DependencyContainer: UseCaseFactory {
    func getPOIsUseCase() -> GetPOIsUseCase {
        return GetPOIsUseCase(service: localHighlightsService())
    }
    func getTagsUseCase() -> GetTagsUseCase {
        return GetTagsUseCase(service: tagService())
    }
}

// MARK: - NetworkService Factory

extension DependencyContainer: NetworkServiceFactory {
    func localHighlightsService() -> LocalHighlightsService {
        return LocalHighlightsService(headers: defaultHeaders, session: session, dataHandler: defaultRequestHandler)
    }
    func tagService() -> TagService {
        return TagService(headers: defaultHeaders, session: session, dataHandler: defaultRequestHandler)
    }
}

// MARK: - Service Factory

extension DependencyContainer: ServiceFactory {
    
}


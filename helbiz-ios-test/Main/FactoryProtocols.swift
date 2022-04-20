//
//  FactoryProtocols.swift
//  StarterTemplate-core
//
//  Created by Dusan on 23.2.22..
//

import Foundation
import UIKit
import Alamofire

// MARK: - ViewControllers

protocol ViewControllerFactory: AnyObject {
    func homeViewController() -> BaseViewController 
}

// MARK: - Coordinators

protocol CoordinatorFactory {

}

// MARK: - Presenters

protocol PresenterFactory {
    func homePresenter() -> HomePresenter
}

// MARK: - UseCases

protocol UseCaseFactory {
    func getPOIsUseCase() -> GetPOIsUseCase
    func getTagsUseCase() -> GetTagsUseCase
}

// MARK: - NetworkServices

protocol NetworkServiceFactory {
    func localHighlightsService() -> LocalHighlightsService
    func tagService() -> TagService
}

// MARK: - Services

protocol ServiceFactory {
    
}

//
//  HomePresenter.swift
//  StarterTemplate-core
//
//  Created by Dusan on 30.3.22..
//

import Foundation

class HomePresenter: Presenter {
    var showAlert: ((String) -> ())?
    var showError: ((String) -> ())?
    var authorizationGranted: ((Bool) -> ())?
    
    private var locationService: LocationService
    private var getPOIsUseCase: GetPOIsUseCase
    private var getTagsUseCase: GetTagsUseCase
    
    var trackingAuthorized = false
    var didSendPOIRequest = false
    
    var poiArray = [Poi]()
    var tagArray = [Tag]()
    var locationId: String?
    var selectedTag: Tag?
    
    init(locationService: LocationService, getPOIsUseCase: GetPOIsUseCase, getTagsUseCase: GetTagsUseCase) {
        self.locationService = locationService
        self.getPOIsUseCase = getPOIsUseCase
        self.getTagsUseCase = getTagsUseCase
        
        setup()
    }
    
    func startTracking() {
        locationService.startService()
        
        if let isTrackingAllowed = locationService.isTrackingAllowed() {
            if !isTrackingAllowed {
                authorizationGranted?(false)
            }
        }
        
        getPOIArray()
    }
    
    // MARK: - UseCases
    
    private func getPOIArray(tag: String? = nil) {
        if let location = locationService.lastKnownLocation {
            getPOIsUseCase.coordinates = location.asCoordinates()
            getPOIsUseCase.tag = tag
            getPOIsUseCase.execute { [weak self] result in
                guard let `self` = self else { return }
                switch result {
                case .success(let pois):
                    self.poiArray = pois
                    self.locationId = pois.first?.locationID
                    
                    self.getTagArray()
                    
                case .failure(let error):
                    self.showError?(error ?? "Failed to get POIs.")
                }
            }
            didSendPOIRequest = true
        }
    }
    
    private func getTagArray() {
        if let locationId = locationId {
            getTagsUseCase.locationId = locationId
            getTagsUseCase.execute { [weak self] result in
                guard let `self` = self else { return }
                switch result {
                case .success(let tags):
                    self.tagArray = tags
                    
                case .failure(let error):
                    self.showError?(error ?? "Failed to get Tags.")
                }
            }
        }
    }
    
    // MARK: - User actions
    
    private func tagTapped(at index: Int) {
        //
    }

    // MARK: - Setup
    
    private func setup() {
        locationService.onAuthorizationGranted = { [weak self] bool in
            self?.trackingAuthorized = bool
            self?.authorizationGranted?(bool)
        }
        locationService.onLocationDidUpdate = { [weak self] coordinates in
            guard let `self` = self else { return }
            if self.trackingAuthorized {
                if self.poiArray.isEmpty && !self.didSendPOIRequest {
                    self.getPOIArray()
                    self.didSendPOIRequest = true
                }
            }
        }
//        locationService.onDidReadFirstLocation = { [weak self] in
//
//        }
    }
    
}

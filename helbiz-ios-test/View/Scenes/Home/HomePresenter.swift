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
    var onTagSelected: ((Tag) -> ())?
    var onPoiSelected: ((Poi) -> ())?
    var onGetPOIsByTagSuccess: (([Poi]) -> ())?
    
    private var locationService: LocationService
    private var getPOIsUseCase: GetPOIsUseCase
    private var getTagsUseCase: GetTagsUseCase
    var tagsViewModel: TagsViewModel
    var poisViewModel: PoisViewModel
    var mapViewModel: MapViewModel
    
    var trackingAuthorized = false
    var didSendFirstRequest = false
    
    var poiArray = [Poi]()
    var tagArray = [Tag]()
    var locationId: String?
    var selectedTag: Tag?
    
    init(locationService: LocationService, getPOIsUseCase: GetPOIsUseCase, getTagsUseCase: GetTagsUseCase,
         tagsViewModel: TagsViewModel, poisViewModel: PoisViewModel, mapViewModel: MapViewModel) {
        self.locationService = locationService
        self.getPOIsUseCase = getPOIsUseCase
        self.getTagsUseCase = getTagsUseCase
        self.tagsViewModel = tagsViewModel
        self.poisViewModel = poisViewModel
        self.mapViewModel = mapViewModel
        
        setupServices()
        setupViewModels()
    }
    
    func startTracking() {
        locationService.startService()
        
        if let isTrackingAllowed = locationService.isTrackingAllowed() {
            if !isTrackingAllowed {
                authorizationGranted?(false)
            }
        }
        
        loadData()
    }
    
    // MARK: - UseCases
    
    func loadData() {
        if let location = locationService.lastKnownLocation {
            getPOIsUseCase.coordinates = location.asCoordinates()
            getPOIsUseCase.tag = nil
            getPOIsUseCase.execute { [weak self] result in
                guard let `self` = self else { return }
                switch result {
                case .success(let pois):
                    let sorted = pois.sorted { $0.distance < $1.distance }
                    
                    self.poiArray = sorted
                    self.locationId = sorted.first?.locationID
                    self.poisViewModel.setup(pois: sorted)
                    
                    self.getTagArray()
                    
                case .failure(let error):
                    self.showError?(error ?? "Failed to get POIs.")
                }
            }
            didSendFirstRequest = true
        }
    }
    
    private func getPOIsByTag(_ tag: Tag) {
        if let location = locationService.lastKnownLocation {
            getPOIsUseCase.coordinates = location.asCoordinates()
            getPOIsUseCase.tag = tag.label
            getPOIsUseCase.execute { [weak self] result in
                guard let `self` = self else { return }
                switch result {
                case .success(let pois):
                    let sorted = pois.sorted { $0.distance < $1.distance }
                    self.poisViewModel.setup(pois: sorted, tagName: tag.name)
                    self.mapViewModel.setup(pois: pois)
                    self.onGetPOIsByTagSuccess?(sorted)
                    
                case .failure(let error):
                    self.showError?(error ?? "Failed to get POIs.")
                }
            }
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
                    self.tagsViewModel.setup(tags: tags)
                    
                case .failure(let error):
                    self.showError?(error ?? "Failed to get Tags.")
                }
            }
        }
    }

    // MARK: - Setup
    
    private func setupServices() {
        locationService.onAuthorizationGranted = { [weak self] bool in
            self?.trackingAuthorized = bool
            self?.authorizationGranted?(bool)
        }
        locationService.onLocationDidUpdate = { [weak self] coordinates in
            guard let `self` = self else { return }
            if self.trackingAuthorized {
                if self.poiArray.isEmpty && !self.didSendFirstRequest {
                    self.loadData()
                    self.didSendFirstRequest = true
                }
            }
        }
    }
    
    private func setupViewModels() {
        tagsViewModel.tagSelected = { [weak self] tag in
            guard let `self` = self else { return }
            self.onTagSelected?(tag)
            self.getPOIsByTag(tag)
        }
        poisViewModel.onPoiSelected = { [weak self] poi in
            self?.onPoiSelected?(poi)
        }
    }
    
}

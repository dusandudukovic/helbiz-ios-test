//
//  GetPOIsUseCase.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import Foundation

class GetPOIsUseCase: UseCase {
    typealias SuccessData = [Poi]
    typealias FailureData = String?
    
    private var service: LocalHighlightsService
    
    var coordinate: Coordinates?
    var tag: String?
    
    init(service: LocalHighlightsService) {
        self.service = service
    }
    
    func execute(completion: ((UseCaseResult<SuccessData, FailureData>) -> Void)?) {
        if let coordinate = coordinate {
            service.getPOIs(coordinate: coordinate, tag: tag) { result in
                switch result {
                case .success(let response):
                    if let localHighlights = try? JSONDecoder().decode(LocalHighlights.self, from: response.data) {
                        if localHighlights.results.count > 0 {
                            let pois = localHighlights.results[0].pois
                            completion?(.success(pois))
                        } else {
                            completion?(.success([]))
                        }
                    }
                case .failure(let error):
                    completion?(.failure(error.message))
                }
            }
        } else {
            completion?(.failure("Couldn't load user coordinates."))
        }
        
    }
    
}

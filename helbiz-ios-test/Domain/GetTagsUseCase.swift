//
//  GetTagsUseCase.swift
//  helbiz-ios-test
//
//  Created by Dusan on 20.4.22..
//

import Foundation

class GetTagsUseCase: UseCase {
    typealias SuccessData = [Tag]
    typealias FailureData = String?
    typealias Result = UseCaseResult<SuccessData, FailureData>
    
    private var service: TagService
    
    var locationId: String?
    
    init(service: TagService) {
        self.service = service
    }
    
    func execute(completion: ((Result) -> Void)?) {
        if let locationId = locationId {
            service.getTags(locationId: locationId) { result in
                switch result {
                case .success(let response):
                    if let tagsResponse = try? JSONDecoder().decode(TagsResponse.self, from: response.data) {
                        if tagsResponse.results.count > 0 {
                            let tags = tagsResponse.results
                            completion?(.success(tags))
                        } else {
                            completion?(.success([]))
                        }
                    }
                case .failure(let error):
                    completion?(.failure(error.message))
                }
            }
            
        } else {
            completion?(.failure("Location not set."))
        }
    }
    
}

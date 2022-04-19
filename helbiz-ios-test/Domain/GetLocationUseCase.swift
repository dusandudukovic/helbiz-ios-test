//
//  GetLocationUseCase.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import Foundation

class GetLocationUseCase: UseCase {
    typealias SuccessData = String
    typealias FailureData = String
    
    private var service: LocalHighlightsService
    
    init(service: LocalHighlightsService) {
        self.service = service
    }
    
    func execute(completion: ((UseCaseResult<SuccessData, FailureData>) -> Void)?) {
        //
    }
    
}

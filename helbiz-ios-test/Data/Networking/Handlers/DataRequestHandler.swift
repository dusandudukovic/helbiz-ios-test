//
//  DataRequestValidator.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import Foundation
import Alamofire

typealias RequestCompletion = (_ responseHandler: NetworkRequestResult) -> Void
typealias RequestCompletionLight = (_ responseHandler: NetworkRequestResultLight) -> Void

protocol DataRequestHandler {
    func handle(request: DataRequest, completion: RequestCompletion?)
}
protocol LightRequestHandler {
    func handle(request: DataRequest, completion: RequestCompletionLight?)
}

// MARK: Classes

class DefaultDataRequestHandler: DataRequestHandler {
    func handle(request: DataRequest, completion: RequestCompletion?) {
        request.validate(statusCode: 200...299).responseData { response in
            let handler = NetworkRequestResult(dataResponse: response)
            completion?(handler)
        }
    }
}

class LightDataRequestHandler: LightRequestHandler {
    // Validates responses based only on statusCode

    func handle(request: DataRequest, completion: RequestCompletionLight?) {
        request.validate(statusCode: 200...299).response { data in
            let handler = NetworkRequestResultLight(dataResponse: data)
            completion?(handler)
        }
    }
}

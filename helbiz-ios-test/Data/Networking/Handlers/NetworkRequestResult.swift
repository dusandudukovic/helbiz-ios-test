//
//  NetworkError.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import Foundation
import Alamofire

struct NetworkResponse {
    var message: String?
    var code: Int
    var data: Data
}

struct NetworkError {
    var message: String?
    var code: Int
}

struct ResponseMessage: Codable {
    var message: String
}

enum NetworkRequestResult {
    case success(NetworkResponse)
    case failure(NetworkError)

    init(dataResponse: AFDataResponse<Data>) {
        let result = dataResponse.result
        let httpResponse = dataResponse.response
        let statusCode = httpResponse?.statusCode ?? 0
        let data = dataResponse.data ?? Data()
        
        switch result {
        case .success:
            self = .success(NetworkResponse(message: nil, code: statusCode, data: data))
            
        case .failure(let error):
            var code = error._code == RequestErrorCode.noConnection ? RequestErrorCode.noConnection : statusCode
            var message = NetworkRequestResult.getMessage(from: data)
            
            if code == 0 && message == nil {
                code = RequestErrorCode.noConnection
                message = RequestErrorCode.noConnectionMessage
            }
            
            self = .failure(NetworkError(message: message, code: code))
        }
    }

    init(_ type: NetworkRequestResult) {
        self = type
    }

    static func getMessage(from data: Data) -> String? {
        let message = try? JSONDecoder().decode(ResponseMessage.self, from: data)
        return message?.message
    }
}

enum NetworkRequestResultLight {
    case success(code: Int, HTTPURLResponse?)
    case failure(code: Int)

    init(dataResponse: AFDataResponse<Data?>) {
        let response = dataResponse.response
        let result = dataResponse.result
        let statusCode = response?.statusCode ?? 0

        switch result {
        case .success(_):
            self = .success(code: statusCode, response)
        case .failure(let error):
            let code = error._code == RequestErrorCode.noConnection ? RequestErrorCode.noConnection : statusCode
            self = .failure(code: code)
        }
    }
}

//
//  TokenManager.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import Alamofire

class TokenManager {
    
    private var headers: HTTPHeaders
    private let appSession: AppSession
    
    init(headers: HTTPHeaders, appSession: AppSession) {
        self.headers = headers
        self.appSession = appSession
    }
    
    func defaultHeaders() -> HTTPHeaders {
        return headers
    }
    
    func basicTokenHeaders() -> HTTPHeaders {
        // add headers if needed
        return headers
    }
    
    func accessTokenHeaders() -> HTTPHeaders {
        var h = headers
        if let token = appSession.accessToken {
            h.add(.authorization(bearerToken: token))
        }
        return h
    }
    
    func accessToken() -> String? {
        return appSession.accessToken
    }
    
    func multipartHeaders(imageType: String) -> HTTPHeaders {
        var h = headers
        if let token = appSession.accessToken {
            h.add(.authorization(bearerToken: token))
        }
        h.add(.contentType("multipart/form-data"))
        h.add(.contentDisposition("form-data"))
        h.add(name: "photo", value: "photo.jpg")
        h.add(name: "side", value: imageType)
        return h
    }
    
}

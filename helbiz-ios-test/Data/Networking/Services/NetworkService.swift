//
//  BaseRequest.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import Foundation
import Alamofire

protocol NetworkService {
    init(headers: HTTPHeaders, session: Session, dataHandler: DataRequestHandler)
}

protocol AuthNetworkService {
    init(tokenManager: TokenManager, session: Session, dataHandler: DataRequestHandler)
}

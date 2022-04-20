//
//  DefaultNetworkConfiguration.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//
//

import Foundation
import Alamofire
import AlamofireNetworkActivityLogger

protocol NetworkConfiguration {
    var session: Session { get }
    var headers: HTTPHeaders { get }
    var dataHandler: DataRequestHandler { get }
}

class DefaultNetworkConfiguration: NetworkConfiguration {
    
    var session: Session
    var headers: HTTPHeaders
    var dataHandler: DataRequestHandler
    
    init() {
        session = Session()
        headers = HTTPHeaders.default
        dataHandler = DefaultDataRequestHandler()
    }
    
}

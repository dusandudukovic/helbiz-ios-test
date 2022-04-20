//
//  TagService.swift
//  helbiz-ios-test
//
//  Created by Dusan on 20.4.22..
//

import Foundation
import Alamofire

class TagService: NetworkService {
    private var headers: HTTPHeaders
    private let session: Session
    private let responseHandler: DataRequestHandler
    
    required init(headers: HTTPHeaders, session: Session, dataHandler: DataRequestHandler) {
        self.headers = headers
        self.session = session
        self.responseHandler = dataHandler
    }
    
    func getTags(locationId: String, completion: RequestCompletion?) {
        let url = RequestEndpoint.tag
        let params: [String : Any] = [
            "location_id": locationId,
            "ancestor_label": "cuisine",
            "order_by": "-poi_count",
            "fields": "name,poi_count,score,label",
            "count": 10
        ]
        
        let request = session.request(url, method: .get, parameters: params, headers: headers)
        responseHandler.handle(request: request, completion: completion)
    }

    
}


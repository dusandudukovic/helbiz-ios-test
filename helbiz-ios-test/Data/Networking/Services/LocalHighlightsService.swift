//
//  LocalHighlightsService.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import Foundation
import Alamofire

class LocalHighlightsService: NetworkService {
    private var headers: HTTPHeaders
    private let session: Session
    private let responseHandler: DataRequestHandler
    
    private let maxDistanceInMeters: Int = 5000
    
    required init(headers: HTTPHeaders, session: Session, dataHandler: DataRequestHandler) {
        self.headers = headers
        self.session = session
        self.responseHandler = dataHandler
    }
    
    func getPOIs(coordinates: Coordinates, tag: String? = "cuisine", completion: RequestCompletion?) {
        let url = RequestEndpoint.localHighlights
        let params: [String : Any] = [
            "latitude": coordinates.latitude,
            "longitude": coordinates.longitude,
            "tag_labels": tag ?? "cuisine",
            "max_distance": maxDistanceInMeters,
            "poi_fields": "id,location_id,name,coordinates,snippet,score,intro,images"
        ]
        
        let request = session.request(url, method: .get, parameters: params, headers: headers)
        responseHandler.handle(request: request, completion: completion)
    }

    
}

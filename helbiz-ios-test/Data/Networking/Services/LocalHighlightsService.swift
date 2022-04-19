//
//  LocalHighlightsService.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import Foundation
import Alamofire
import CoreLocation

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
    
    func getLocationId(coordinate: CLLocationCoordinate2D, completion: RequestCompletion?) {
        let url = RequestEndpoint.localHighlights
        let params: [String : Any] = [
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude,
            "tag_labels": "eatingout",
            "max_distance": maxDistanceInMeters,
            "poi_fields": "location_id"
        ]
        
        let request = session.request(url, method: .get, parameters: params, headers: headers)
        responseHandler.handle(request: request, completion: completion)
    }
    
    func getPOIs(coordinate: CLLocationCoordinate2D, tag: String, completion: RequestCompletion?) {
        let url = RequestEndpoint.localHighlights
        let params: [String : Any] = [
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude,
            "tag_labels": tag,
            "max_distance": maxDistanceInMeters,
            "poi_fields": "id,name,coordinates,snippet,score,intro,images"
        ]
        
        let request = session.request(url, method: .get, parameters: params, headers: headers)
        responseHandler.handle(request: request, completion: completion)
    }

    
}

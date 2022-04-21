//
//  RequestEndpoint.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import Foundation

struct RequestEndpoint {
    
    // MARK: Base
    
    static let scheme = "https"
    static let apiVersion = "api/20220411/"
    static let base = scheme + "://www.triposo.com/" + apiVersion
    
    // MARK: Specific
    
    static let localHighlights = base + "local_highlights.json"
    static let tag = base + "tag.json"
    
}

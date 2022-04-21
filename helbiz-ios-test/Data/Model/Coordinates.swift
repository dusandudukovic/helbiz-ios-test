//
//  Coordinates.swift
//  helbiz-ios-test
//
//  Created by Dusan on 20.4.22..
//

import Foundation
import CoreLocation

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

extension Coordinates {
    func toCLLocation2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

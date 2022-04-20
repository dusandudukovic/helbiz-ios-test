//
//  CLLocation+Extension.swift
//  helbiz-ios-test
//
//  Created by Dusan on 20.4.22..
//

import Foundation
import CoreLocation

extension CLLocation {
    func asCoordinates() -> Coordinates {
        return Coordinates(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
    }
}

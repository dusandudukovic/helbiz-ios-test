//
//  MapViewModel.swift
//  helbiz-ios-test
//
//  Created by Dusan on 21.4.22..
//

import Foundation
import CoreLocation

class MapViewModel {
    
    var updateMarkers: (([CLLocationCoordinate2D]) -> ())?
    
    var coordinates = [CLLocationCoordinate2D]()
    
    func setup(pois: [Poi]) {
        coordinates.removeAll()
        for poi in pois {
            coordinates.append(poi.coordinates.toCLLocation2D())
        }
        
        updateMarkers?(coordinates)
    }
    
}

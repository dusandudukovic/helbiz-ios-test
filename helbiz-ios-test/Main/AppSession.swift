//
//  AppSession.swift
//  StarterTemplate-core
//
//  Created by Dusan on 23.2.22..
//

import Foundation
import CoreLocation

class AppSession {
    
    private let userDefaults = UserDefaults.standard
    
    var accessToken: String? {
        get {
            return userDefaults.object(forKey: "access_token") as? String
        }
        set {
            userDefaults.set(newValue, forKey: "access_token")
        }
    }
    
    var lastKnownLocation: CLLocationCoordinate2D? {
        get {
            let lon = userDefaults.object(forKey: "lastKnownLocationLon") as? Double
            let lat = userDefaults.object(forKey: "lastKnownLocationLat") as? Double
            
            guard let longitude = lon else {
                return nil
            }
            
            guard let latitude = lat else {
                return nil
            }
            
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        set {
            if let newValue = newValue {
                userDefaults.set(newValue.latitude, forKey: "lastKnownLocationLat")
                userDefaults.set(newValue.longitude, forKey: "lastKnownLocationLon")
            } else {
                userDefaults.set(nil, forKey: "lastKnownLocationLat")
                userDefaults.set(nil, forKey: "lastKnownLocationLon")
            }
        }
    }


}

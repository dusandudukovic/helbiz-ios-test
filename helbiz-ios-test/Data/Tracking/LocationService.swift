//
//  LocationService.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    var onLocationDidUpdate: ((Coordinates) -> ())?
    var onAuthorizationGranted: ((Bool) -> ())?
    
    private var locationManager: CLLocationManager?
    private var didReadFirstLocation = false
    private var appSession: AppSession?
    
    var lastKnownLocation: CLLocation? {
        didSet {
            if let coordinate = lastKnownLocation?.coordinate {
                appSession?.lastKnownLocation = coordinate
            }
        }
    }
    
    init(appSession: AppSession, locationManager: CLLocationManager) {
        super.init()
        
        self.appSession = appSession
        self.locationManager = locationManager
        locationManager.delegate = self
    }
    
    func startService() {
        let status = locationManager?.authorizationStatus

        if status == .notDetermined {
            locationManager?.requestWhenInUseAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func isTrackingAllowed() -> Bool? {
        if locationManager?.authorizationStatus == .notDetermined {
            return nil
        }
        return locationManager?.authorizationStatus == .authorizedWhenInUse
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
            onAuthorizationGranted?(true)
        } else if status == .denied {
            onAuthorizationGranted?(false)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lastKnownLocation = location
            onLocationDidUpdate?(location.asCoordinates())
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("TrackingManager - didFailWithError: \(error.localizedDescription)")
        startService()
    }
    
}

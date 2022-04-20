//
//  LocationService.swift
//  helbiz-ios-test
//
//  Created by Dusan on 19.4.22..
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    var onLocationDidUpdate: ((CLLocation) -> ())?
    var onDidReadFirstLocation: (() -> ())?
    
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
    
    func requestAuthorization() {
        let status = locationManager?.authorizationStatus

        if status == .notDetermined {
            locationManager?.requestWhenInUseAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lastKnownLocation = location
            onLocationDidUpdate?(location)
            
            if !didReadFirstLocation {
                didReadFirstLocation = true
                onDidReadFirstLocation?()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("TrackingManager - didFailWithError: \(error.localizedDescription)")
        requestAuthorization()
    }
    
}

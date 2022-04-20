//
//  MapView.swift
//  helbiz-ios-test
//
//  Created by Dusan on 20.4.22..
//

import Foundation
import GoogleMaps

class MapView: ViewWithNib {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    private var markers: [GMSMarker]?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Camera control
    
    func moveCameraToUser() {
        if let myLocation = mapView.myLocation {
            moveCamera(to: myLocation.coordinate, animated: false, zoom: 15)
        }
    }
    
    func moveCamera(to coordinate: CLLocationCoordinate2D, animated: Bool, zoom: Float? = nil) {
        let currentZoom = mapView.camera.zoom
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom ?? currentZoom)
        
        if animated {
            animateCameraChange(camera: camera)
        } else {
            mapView.camera = camera
        }
        
    }
    
    private func animateCameraChange(camera: GMSCameraPosition) {
        CATransaction.begin()
        CATransaction.setValue(0.8, forKey: kCATransactionAnimationDuration)
        mapView.animate(to: camera)
        CATransaction.commit()
    }
    
    // MARK: - Marker control
    
    func showMarkers(_ newMarkers: [GMSMarker]) {
        removeMarkers()
        markers = newMarkers
        
        for marker in newMarkers {
            marker.map = mapView
        }
    }
    
    func removeMarkers() {
        if let markers = markers {
            for marker in markers {
                marker.map = nil
            }
        }
        markers?.removeAll()
    }
    
    // MARK: - Configuration
    
    private func setup() {
        mapView.isMyLocationEnabled = true
    }
    
}

extension MapView: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //
        return true
    }
    
}

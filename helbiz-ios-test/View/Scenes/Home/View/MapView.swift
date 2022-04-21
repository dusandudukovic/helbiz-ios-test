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
    
    private var markers = [GMSMarker]()
    private let defaultZoom: Float = 12
    
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
            moveCamera(to: myLocation.coordinate, animated: false, zoom: defaultZoom)
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
    
    func createMarkers(from coordinates: [CLLocationCoordinate2D]) {
        removeMarkers()
        
        for coordinate in coordinates {
            let marker = GMSMarker(position: coordinate)
            marker.map = mapView
            markers.append(marker)
        }
    }
    
    func removeMarkers() {
        for marker in markers {
            marker.map = nil
        }
        
        markers.removeAll()
    }
    
    // MARK: - Configuration
    
    func setup(with viewModel: MapViewModel?) {
        guard let viewModel = viewModel else { return }
        createMarkers(from: viewModel.coordinates)
        
        viewModel.updateMarkers = { [weak self] coordinates in
            self?.createMarkers(from: coordinates)
        }
    }
    
    private func setup() {
        mapView.isMyLocationEnabled = true
        
        do {
            if let file = Bundle.main.url(forResource: "map_style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: file)
            } else {
                print("'map_style.json' file not found. Showing map with default styles.")
            }
        } catch let error {
            print("The map style definition could not be loaded: \(error)")
        }
        
    }
    
}

extension MapView: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //
        return true
    }
    
}

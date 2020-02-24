//
//  MapManager.swift
//  tabbedApp
//
//  Created by Ivan on 11.02.2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation
import MapKit

class MapManager {
    static let shared = MapManager()
    
    var mapView: MKMapView?
    
    var places: [Place] = [
        Place(title: "42", subtitle: "Paris IT School", latitude: 48.896652, longitude: 2.3184955, color: UIColor.green),
        Place(title: "Unit Factory", subtitle: "Kyiv IT School", latitude: 50.4688257, longitude: 30.4621588, color: UIColor.yellow),
        Place(title: "Berlin", subtitle: "Capital of Great Britain", latitude: 52.5200066, longitude: 13.404954, color: UIColor.red),
    ]
    
    func centerMapOnLocation(mapView: MKMapView, location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        
		let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

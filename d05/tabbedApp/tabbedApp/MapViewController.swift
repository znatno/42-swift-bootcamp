//
//  FirstViewController.swift
//  tabbedApp
//
//  Created by Ivan on 11.02.2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

	@IBOutlet weak var mapView: MKMapView!
	
	let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Load")
        
        MapManager.shared.mapView = mapView
		if let indexOfStartLocation = MapManager.shared.places.firstIndex(where: { $0.title == "42" }) {
            MapManager.shared.centerMapOnLocation(mapView: mapView, location: MapManager.shared.places[indexOfStartLocation].location)
        }
        initAnnotations()
    }

	
	@IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = .standard
        } else if sender.selectedSegmentIndex == 1 {
            mapView.mapType = .satellite
        } else {
            mapView.mapType = .hybrid
        }
	}
	
	
	@IBAction func locationButtonTapped(_ sender: UIButton) {
		checkLocationAuthorizationStatus()
	}
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func initAnnotations() {
        for location in MapManager.shared.places {
            let annotation = MKPointAnnotation()
            
            annotation.title = location.title
            annotation.subtitle = location.subtitle
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation else { return nil }
        
        let identifier = "mapPin"
        var annotaionView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotaionView == nil {
            annotaionView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "mapPin")
            annotaionView?.canShowCallout = true
        } else {
            annotaionView!.annotation = annotation
        }
        
        return annotaionView
    }

}


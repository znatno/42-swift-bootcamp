//
//  ViewController.swift
//  mapApp
//
//  Created by Ivan on 16.02.2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class customPin: NSObject, MKAnnotation {
	
	var coordinate: CLLocationCoordinate2D
	var title: String?
	var subtitle: String?
	
	init(pinTitle: String, pinSubtitle: String, location: CLLocationCoordinate2D) {
		self.title = pinTitle
		self.subtitle = pinSubtitle
		self.coordinate = location
	}
}

class ViewController: UIViewController, MKMapViewDelegate {
	
	// MARK: - Variables
	
	var sourceLocation: CLLocationCoordinate2D?
	var destinationLocation: CLLocationCoordinate2D?
	
	//
	//
	//
	//	required init() {
	//		super.init()
	//
	//		self.sourceLocation = CLLocationCoordinate2D(latitude:39.173209 , longitude: -94.593933)
	//		self.destinationLocation = CLLocationCoordinate2D(latitude:38.643172 , longitude: -90.177429)
	//	}
	
	// MARK: - Outlets
	
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var sourceField: UITextField!
	@IBOutlet weak var destField: UITextField!
	
	@IBAction func getRouteButtonPressed(_ sender: UIButton) {
		
        // default location
		let defSourceLocation = CLLocationCoordinate2D(latitude:39.173209 , longitude: -94.593933)
		let defDestinationLocation = CLLocationCoordinate2D(latitude:38.643172 , longitude: -90.177429)
		
		//getAddresses()
		
		// 1
		getCoordinateFrom(address: sourceField.text ?? "New York") { coordinate, error in
			guard let coordinate = coordinate, error == nil else {
				print("err1")
				return
				
			}
			DispatchQueue.main.async {
				print(self.sourceField.text!, "Location:", coordinate)
				self.sourceLocation = coordinate
			}
		}
		
		// 2
		getCoordinateFrom(address: destField.text ?? "Boston") { coordinate, error in
			guard let coordinate = coordinate, error == nil else {
				print("err2")
				return
			}
			DispatchQueue.main.async {
				print(self.destField.text!, "Location:", coordinate)
				self.destinationLocation = coordinate
			}
		}
		
		let sourcePin = customPin(pinTitle: "Source", pinSubtitle: "", location: sourceLocation ?? defSourceLocation)
		let destinationPin = customPin(pinTitle: "Destination", pinSubtitle: "", location: destinationLocation ?? defDestinationLocation)
		
		self.mapView.addAnnotation(sourcePin)
		self.mapView.addAnnotation(destinationPin)
		
		let sourcePlacemark = MKPlacemark(coordinate: sourceLocation ?? defSourceLocation)
		let destinationPlacemark = MKPlacemark(coordinate: destinationLocation ?? defDestinationLocation)
		
		let directionRequest = MKDirections.Request()
		directionRequest.source = MKMapItem(placemark: sourcePlacemark)
		directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
		directionRequest.transportType = .automobile
		
		let directions = MKDirections(request: directionRequest)
		directions.calculate { (response, error) in
			guard let directionResonse = response else {
				if let error = error {
					print("We have error getting directions == \(error.localizedDescription)")
				}
				return
			}
			
			let route = directionResonse.routes[0]
			self.mapView.addOverlay(route.polyline, level: .aboveRoads)
			
			let rect = route.polyline.boundingMapRect
			self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
		}
		
		self.mapView.delegate = self
		
		
	}
	
	func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
		CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
	}
	
	func getAddresses() {
		
		print("\n\nGET LOCATIONS START\n\n")
		
		print("Inputs:")
		print(sourceField.text!)
		print(destField.text!)
		print("")
		
		// 1
		getCoordinateFrom(address: sourceField.text ?? "New York") { coordinate, error in
			guard let coordinate = coordinate, error == nil else { return }
			DispatchQueue.main.async {
				print(self.sourceField.text!, "Location:", coordinate)
				self.sourceLocation = coordinate
			}
		}
		
		// 2
		getCoordinateFrom(address: destField.text ?? "Boston") { coordinate, error in
			guard let coordinate = coordinate, error == nil else { return }
			DispatchQueue.main.async {
				print(self.destField.text!, "Location:", coordinate)
				self.destinationLocation = coordinate
			}
		}
		
		print("\n\nGET LOCATIONS END\n\n")
	}
	
	
	// MARK: - MapKit delegates
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		let renderer = MKPolylineRenderer(overlay: overlay)
		renderer.strokeColor = UIColor.blue
		renderer.lineWidth = 4.0
		return renderer
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
}


//
//  Place.swift
//  tabbedApp
//
//  Created by Ivan on 11.02.2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let latitude: Double
    let longitude: Double
    let color: UIColor
    
    let coordinate: CLLocationCoordinate2D
    
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    init(title: String, subtitle: String, latitude: Double, longitude: Double, color: UIColor) {
        self.title = title
        self.subtitle = subtitle
        self.latitude = latitude
        self.longitude = longitude
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.color = color
        
        super.init()
    }
}

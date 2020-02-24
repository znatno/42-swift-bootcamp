//
//  SecondViewController.swift
//  tabbedApp
//
//  Created by Ivan on 11.02.2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var tableView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MapManager.shared.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)
        
        cell.textLabel?.text = MapManager.shared.places[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MapManager.shared.centerMapOnLocation(mapView: MapManager.shared.mapView!, location: MapManager.shared.places[indexPath.row].location)
        tableView.deselectRow(at: indexPath, animated: true)
        tabBarController?.selectedIndex = 0
    }
    
}


//
//  ViewController.swift
//  d07
//
//  Created by Ivan BOHUN on 2/13/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

class ViewController: UIViewController, APIControllerDelegate {
    
    let recastToken = "7e4c539ff8e19fe651c92e25fef3282c"
    let darkSkyToken = "8cb8ff647eddc68f24405642078df318"
    
    func receivedResponse(response: String) {
        print("kek")
        print(response)
        
        infoLabel.text = (infoLabel.text!) + ":\n" + response
        infoLabel.numberOfLines = 0
    }
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var searchInput: UITextField!
    
    var apiController: APIController!

    
    @IBAction func getButtonPressed(_ sender: UIButton) {
        
        guard let searchText = searchInput.text else { return }
        print("searchButton pressed: \(searchText)")
        
        self.infoLabel.text = "Weather in " + searchText
        apiController.searchForWeatherAt(text: searchText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiController = APIController(delegate: self, recastToken: recastToken, darkSkyToken: darkSkyToken)
    }
}

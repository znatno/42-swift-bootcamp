//
//  APIController.swift
//  d07
//
//  Created by Ivan BOHUN on 2/13/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import RecastAI
import ForecastIO
import Foundation
import CoreLocation

protocol APIControllerDelegate: class {
    func receivedResponse(response: String)
    
    var recastToken: String { get }
    var darkSkyToken: String { get }
}

class APIController {
    weak var delegate: APIControllerDelegate?
    let bot: RecastAIClient?
    let client: DarkSkyClient?
    
    init(delegate: APIControllerDelegate?, recastToken: String, darkSkyToken: String) {
        self.delegate = delegate
        self.bot = RecastAIClient(token: recastToken)
        self.client = DarkSkyClient(apiKey: darkSkyToken)
        self.client?.language = .english
    }
    
    func searchForWeatherAt(text: String) {
        if text != "" && text.count < 512 {
            bot?.textRequest(text, successHandler: successHandler, failureHandle: errorHandler)
        }
    }
    
    private func successHandler(_ response: Response) {
        if let locations = response.all(entity: "location") {
            for location in locations {
                print(location)
                
                guard let lat = location["lat"] as? Double, let lng = location["lng"] as? Double else { continue }
                
                let myLoc = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                
                // Forecast API
                let excludeFields: [Forecast.Field] = [.currently, .minutely, .hourly, .flags, .alerts]
                client?.getForecast(location: myLoc, excludeFields: excludeFields) { [weak self] (result) in
                    print("=== RESPONSE ===")
                    print(response)
                    print("")
                    switch result {
                    case .success(let forecast):
                        
                        guard let summary = forecast.0.daily?.summary else {
                            DispatchQueue.main.async {
                                self?.delegate?.receivedResponse(response: "Some error")
                            }
                            break
                        }
                        DispatchQueue.main.async {
                            self?.delegate?.receivedResponse(response: summary)
                        }
                    case .failure(let error):
                        print(error)
                        
                        DispatchQueue.main.async {
                            self?.delegate?.receivedResponse(response: "Some error")
                        }
                    }
                }
                // End
                
            }
        } else {
            DispatchQueue.main.async {
                self.delegate?.receivedResponse(response: "Didn't recognize any location")
            }
        }
    }
    
    private func errorHandler(_ error: Error) {
        print(error)
        
        DispatchQueue.main.async {
            self.delegate?.receivedResponse(response: error.localizedDescription)
        }
    }
}

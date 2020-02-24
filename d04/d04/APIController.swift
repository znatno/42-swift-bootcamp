//
//  APIController.swift
//  d04
//
//  Created by Ivan BOHUN on 2/8/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import Foundation
import UIKit

protocol APITwitterDelegate: class {
	
	func processTweets(tweets: [Tweet])
	func processError(error: Error)
	
}

class APIController {
	
	weak var delegate: APITwitterDelegate?
	let token: String
	
	init (delegate: APITwitterDelegate?, token: String) {
		
		self.delegate = delegate
		self.token = token
		
	}
	
	func getTweets (keyword: String) {
		
		let count = 100
		guard let q = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?q=\(q)&count=\(count)&land=en&result_type=recent") else { return }
		
		let request = NSMutableURLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		
		let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
			if let e = error {
				DispatchQueue.main.async {
					self.delegate?.processError(error: e)
				}
			}
			else if let d = data {
				do {
					if let dict = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
						var tweets: [Tweet] = []
						if let tweetsDict: [NSDictionary] = dict["statuses"] as? [NSDictionary] {
							for tweet in tweetsDict {
								guard let user = tweet["user"] as? NSDictionary, let name = user["name"] as? String, let text = tweet["text"] as? String else { continue }
								if let dateString = tweet["created_at"] as? String {
									let dateFormatter = DateFormatter()
									dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
									if let date = dateFormatter.date(from: dateString) {
										tweets.append(Tweet(name: name, text: text, date: date))
									}
								}
							}
							DispatchQueue.main.async {
								self.delegate?.processTweets(tweets: tweets)
							}
						}
						else {
							print("Some error")
						}
					}
				}
				catch (let err) {
					DispatchQueue.main.async {
						self.delegate?.processError(error: err)
					}
				}
			}
			else {
				print("Some error")
			}
		}
		task.resume()
	}
	
}


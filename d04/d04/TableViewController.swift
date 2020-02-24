//
//  ViewController.swift
//  d04
//
//  Created by Ivan BOHUN on 2/8/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, APITwitterDelegate {
	
	@IBOutlet weak var searchInput: UITextField!
	@IBOutlet weak var tableView: UITableView!
	
	func processTweets(tweets: [Tweet]) {
		print(tweets)
		self.tweets = tweets
		tableView.reloadData()
	}
	
	func processError(error: Error) {
		let message = String(describing: error)
		
		if let currentAlert = self.presentedViewController as? UIAlertController {
			currentAlert.message = (currentAlert.message ?? "") + "\n\(message)"
			return
		}
		
		let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		searchInput.resignFirstResponder()
		newSearch(keyword: textField.text ?? "")
		return true
	}
	
	var token: String?
	var tweets: [Tweet] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		searchInput.delegate = self
		
		getToken() { [weak self] in
			if let token = self?.token {
				let twitterAPI = APIController(delegate: self, token: token)
				twitterAPI.getTweets(keyword: "school 42")
			}
		}
	}
	
	func newSearch(keyword: String) {
		guard let token = token else { return }
		let twitterAPI = APIController(delegate: self, token: token)
		
		if keyword != "" {
			twitterAPI.getTweets(keyword: keyword)
		}
	}
	
	func getToken(completition: @escaping () -> Void) {
		
		let consumerKey = "bl4TdRbdxhGvKMhSq9gt0YMGU"
		let consumerSecret = "VxsZs6VGhU7umnXT8bGL534WBWcpYOcuemX7c7Xe12CH0PYcqK"
		var bearer: String {
			return ((consumerKey + ":" + consumerSecret).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
		}
		
		let url = URL(string: "https://api.twitter.com/oauth2/token")
		let request = NSMutableURLRequest(url: url!)
		
		request.httpMethod = "POST"
		request.setValue("Basic " + bearer, forHTTPHeaderField: "Authorization")
		request.setValue("application/x-www-form-urlencoded;charset=UTF-8.", forHTTPHeaderField: "Content-Type")
		request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
		
		let task = URLSession.shared.dataTask(with: request as URLRequest) { [weak self] (data, response, error) in
			if let err = error {
				print(err)
			}
			else if let d = data {
				do {
					if let dict = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, String> {
						print(dict)
						if dict["token_type"] == "bearer" {
							self?.token = dict["access_token"]
							print("OK")
							completition()
						}
					}
				}
				catch (let err) {
					print(err)
				}
			}
		}
		
		task.resume()
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tweets.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TableViewCell
		
		// Configure the cell...
		cell.selectionStyle = .none
		cell.showTweet(tweet: tweets[indexPath.row])
		cell.tweetTextLabel.numberOfLines = 0
		
		return cell
	}

}


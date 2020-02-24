//
//  TableViewCell.swift
//  d04
//
//  Created by Ivan BOHUN on 2/8/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
	
	@IBOutlet weak var nicknameLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var tweetTextLabel: UILabel!
	
	func showTweet(tweet: Tweet) {

		nicknameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		
		nicknameLabel.text = tweet.name
		dateLabel.text = dateFormatter.string(from: tweet.date)
		tweetTextLabel.text = tweet.text
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}

}

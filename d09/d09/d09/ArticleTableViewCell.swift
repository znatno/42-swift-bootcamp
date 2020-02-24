//
//  ArticleTableViewCell.swift
//  d09
//
//  Created by Ivan on 15.02.2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit
import ibohun2020

class ArticleTableViewCell: UITableViewCell {
	
	@IBOutlet weak var articleTitle: UILabel!
	@IBOutlet weak var articleContent: UITextView!
	@IBOutlet weak var articleImage: UIImageView!
	@IBOutlet weak var articleCreationDate: UILabel!
	@IBOutlet weak var articleModificationDate: UILabel!
	
	
	// TODO: add outlets
	
	func displayContent(article: Article) {
		articleTitle.text = article.title
		
		if article.image == nil {
			articleImage.isHidden = true
		} else {
			articleImage.isHidden = false
			articleImage.image = UIImage(data: article.image!)
		}
		
		articleContent.text = article.content
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		dateFormatter.timeStyle = .short
		articleCreationDate.text = "\(NSLocalizedString("Creation", comment: "")): \(dateFormatter.string(from: article.creationDate!))"
		if article.creationDate != article.modificationDate {
			articleModificationDate.isHidden = false
			articleModificationDate.text = "\(NSLocalizedString("Modification", comment: "")): \(dateFormatter.string(from: article.modificationDate!))"
		} else {
			articleModificationDate.isHidden = true
		}
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

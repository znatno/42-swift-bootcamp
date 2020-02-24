//
//  ImageCollectionViewCell.swift
//  apm
//
//  Created by Ivan BOHUN on 2/7/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	
	func showImage(image: UIImage) {
		imageView.image = image
		activityIndicator.stopAnimating()
	}
	
}

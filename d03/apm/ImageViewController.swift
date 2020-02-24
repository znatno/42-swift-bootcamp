//
//  ImageViewController.swift
//  apm
//
//  Created by Ivan BOHUN on 2/7/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit

class ImageViewController: ViewController {

	@IBOutlet weak var scrollView: UIScrollView!
	
	var imageView: UIImageView?
	var image: UIImage?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		UIApplication.shared.isNetworkActivityIndicatorVisible = false
		setupUI()
		updateMinZoomScaleForSize(view.bounds.size)
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		updateMinZoomScaleForSize(view.bounds.size)
	}
	
	func setupUI() {
		imageView = UIImageView(image: image)
		scrollView.addSubview(imageView!)
		
		scrollView.contentSize = imageView!.frame.size
	}
	
	func updateMinZoomScaleForSize(_ size: CGSize)
	{
		let widthScale = size.width / imageView!.bounds.width
		
		scrollView.maximumZoomScale = 100.0
		scrollView.minimumZoomScale = widthScale
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
	
}

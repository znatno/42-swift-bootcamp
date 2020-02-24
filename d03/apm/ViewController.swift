//
//  ViewController.swift
//  d03
//
//  Created by Ivan BOHUN on 2/7/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	
	var imageURLs: [String] = [
		"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/stationmoon.jpg",
		"https://aeSFASDFASDF",
		"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/49493580676_2fde6bc677_k.jpg",
		"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/49395543128_bc6c04732c_k.jpg",
		"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/s20-005_core_stage_installation_2718.jpg",
		"https://dlkfjalkdjfaskd",
		"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/bd20307_fnl_lynettecook_0.jpg",
		]
	
	var images: [UIImage] = []
	var shownImages: Int = 0
	var noImage: [Int] = []
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return imageURLs.count
	}
	
	func showAlert(urlString: String) {
		
		let message = "Error download \(urlString)"
		
		if let currentAlert = self.presentedViewController as? UIAlertController {
			currentAlert.message = (currentAlert.message ?? "") + "\n\(message)"
			return
		}
		
		let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
		
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
		
		let url = URL(string: imageURLs[indexPath.row])!
		
		URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
			
			if error == nil {
				if let imageData = data {
					let image = UIImage(data: imageData)
					
					DispatchQueue.main.async {
						cell.showImage(image: image!)
					}
				}
				else {
					self?.noImage.append(indexPath.row)
					DispatchQueue.main.async { [weak self] in
						self?.showAlert(urlString: "\(url)")
						cell.showImage(image: UIImage(named: "error")!)
					}
				}
			}
			else {
				self?.noImage.append(indexPath.row)
				DispatchQueue.main.async { [weak self] in
					self?.showAlert(urlString: "\(url)")
					cell.showImage(image: UIImage(named: "error")!)
				}
			}
			
			self?.shownImages += 1
			if self?.shownImages == self?.imageURLs.count {
				DispatchQueue.main.async {
					UIApplication.shared.isNetworkActivityIndicatorVisible = false
				}
			}
			
			}.resume()
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if noImage.index(of: indexPath.row) != nil {
			return
		}
		performSegue(withIdentifier: "backImages", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "backImages" {
			let destination = segue.destination as! ImageViewController
			let indexPathForSelected = collectionView.indexPathsForSelectedItems
			let cell = collectionView.cellForItem(at: indexPathForSelected!.first!) as! ImageCollectionViewCell
			collectionView.deselectItem(at: indexPathForSelected!.first!, animated: false)
			
			let image = cell.imageView.image
			destination.image = image
		}
		
	}
	
}


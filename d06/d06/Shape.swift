//
//  Shape.swift
//  d06
//
//  Created by Ivan BOHUN on 2/12/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import Foundation
import UIKit

class Shape: UIView {
	
	init(x: CGFloat, y: CGFloat) {
		let frame = CGRect(x: x, y: y, width: 100.0, height: 100.0)
		super.init(frame: frame)
		
		// Random configurations
		self.backgroundColor = .random()
		if arc4random_uniform(2) == 1 { // Random circle or square
			self.layer.cornerRadius = self.frame.size.width / 2.0
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
}

// Extensions for random color

extension CGFloat {
	static func random() -> CGFloat {
		return CGFloat(arc4random()) / CGFloat(UInt32.max)
	}
}

extension UIColor {
	static func random() -> UIColor {
		return UIColor(red:   .random(),
					   green: .random(),
					   blue:  .random(),
					   alpha: 1.0)
	}
}

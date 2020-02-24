//
//  ViewController.swift
//  d06
//
//  Created by Ivan BOHUN on 2/12/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

	var dynamicAnimator:		UIDynamicAnimator!
	var dynamicItemBehavior:	UIDynamicItemBehavior!
	var gravityBehavior:		UIGravityBehavior!
	var collisionBehavior:		UICollisionBehavior!
	var coreMotionManager:		CMMotionManager!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("ready")
		
		// Init
		dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
		dynamicItemBehavior = UIDynamicItemBehavior()
		gravityBehavior = UIGravityBehavior()
		collisionBehavior = UICollisionBehavior()
		
		// Config
		dynamicItemBehavior.elasticity = 0.6
		collisionBehavior.translatesReferenceBoundsIntoBoundary = true
		
		// Behavior
		dynamicAnimator.addBehavior(dynamicItemBehavior)
		dynamicAnimator.addBehavior(gravityBehavior)
		dynamicAnimator.addBehavior(collisionBehavior)
		
		// CoreMotion
		coreMotionManager = CMMotionManager()
		if coreMotionManager.isAccelerometerAvailable {
			coreMotionManager.accelerometerUpdateInterval = 0.1
			coreMotionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler:  accelerometerHandler(data:error:))
		}
	}
	
	@IBAction func tapGestureRecognized(_ gestureRecognizer: UITapGestureRecognizer) {
		guard gestureRecognizer.view != nil else { return }
		
		if gestureRecognizer.state == .ended {
			print("tapped: \(gestureRecognizer.location(in: view))")
			
			let x = gestureRecognizer.location(in: view).x
			let y = gestureRecognizer.location(in: view).y
			let newShape = Shape(x: x - 50.0, y: y - 50.0)
			
			view.addSubview(newShape)
			
			dynamicItemBehavior.addItem(newShape)
			collisionBehavior.addItem(newShape)
			gravityBehavior.addItem(newShape)
			
			let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
			let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureRecognized(_:)))
			let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotateGestureRecognized(_:)))
			
			newShape.addGestureRecognizer(panGestureRecognizer)
			newShape.addGestureRecognizer(pinchGestureRecognizer)
			newShape.addGestureRecognizer(rotateGestureRecognizer)
		}
		
	}
	
	// pan
	@objc func panGestureRecognized(_ panGesture: UIPanGestureRecognizer) {
		guard let view = panGesture.view else { return }
		
		if panGesture.state == .began {
			print("pan -> began")
			gravityBehavior.removeItem(view)
		}
		else if panGesture.state == .began || panGesture.state == .changed {
			print("pan: \(panGesture.location(in: view))")
			view.center = panGesture.location(in: view.superview)
			dynamicAnimator.updateItem(usingCurrentState: view)
		}
		else if panGesture.state == .ended {
			print("pan -> ended")
			
			gravityBehavior.addItem(view)
		}
		
	}
	
	// pitch
	@objc func pinchGestureRecognized(_ pinchGesture: UIPinchGestureRecognizer) {
		guard let view = pinchGesture.view else { return }
		
		switch pinchGesture.state {
		case .began:
			print("pinch -> began")
			
			gravityBehavior.removeItem(view)
			
		case .changed:
			print("pinch: \(pinchGesture.scale)")
			
			let newSize = view.layer.bounds.width * pinchGesture.scale
			let oldCeter = view.center
			
			pinchGesture.scale = 1.0
			if newSize < 10 { return }
			dynamicItemBehavior.removeItem(view)
			collisionBehavior.removeItem(view)
			view.frame = CGRect(x: 0, y: 0, width: newSize, height: newSize)
			view.center = oldCeter
			if view.layer.cornerRadius != 0 {
				view.layer.cornerRadius = view.frame.size.width / 2.0
			}
			collisionBehavior.addItem(view)
			dynamicItemBehavior.addItem(view)
			dynamicAnimator.updateItem(usingCurrentState: view)
			
		case .ended:
			print("pinch -> ended")
			gravityBehavior.addItem(view)
			
		default:
			break
		}
	}
	
	// rotate
	@objc func rotateGestureRecognized(_ rotateGesture: UIRotationGestureRecognizer) {
		guard let view = rotateGesture.view else { return }
		
		switch rotateGesture.state {
		case .began:
			print("rotate -> began")
			gravityBehavior.removeItem(view)
			collisionBehavior.removeItem(view)
			dynamicItemBehavior.removeItem(view)
			
		case .changed:
			print("rotate: \(rotateGesture.rotation)")
			view.transform = CGAffineTransform(rotationAngle: rotateGesture.rotation)
			dynamicAnimator.updateItem(usingCurrentState: view)
			
		case .ended:
			print("rotate -> ended")
			gravityBehavior.addItem(view)
			collisionBehavior.addItem(view)
			dynamicItemBehavior.addItem(view)
			
		default:
			break
		}
	}
	
	// accelometer
	func accelerometerHandler(data: CMAccelerometerData?, error: Error?) {
		guard let data = data else { return }
		print("accelerometer handler")
		
		let x = data.acceleration.x
		let y = data.acceleration.y
		
		self.gravityBehavior.gravityDirection = CGVector(dx: x, dy: y)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}


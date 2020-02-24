//
//  ViewController.swift
//  d00
//
//  Created by Ivan BOHUN on 2/3/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var intLabel: Int = 0
	var isIntLabelChanged = false
	var isZeroDevision = false
	var values: [Int] = []
	var opers: [String] = []
	var isOpPerformed = false
	
	@IBOutlet weak var label: UILabel!
	
	@IBAction func buttons(_ sender: UIButton) {
		guard let title = sender.titleLabel?.text else { return }
		
		switch title {
		case "0":
			numButtonPress(Int(title)!)
		case "1":
			numButtonPress(Int(title)!)
		case "2":
			numButtonPress(Int(title)!)
		case "3":
			numButtonPress(Int(title)!)
		case "4":
			numButtonPress(Int(title)!)
		case "5":
			numButtonPress(Int(title)!)
		case "6":
			numButtonPress(Int(title)!)
		case "7":
			numButtonPress(Int(title)!)
		case "8":
			numButtonPress(Int(title)!)
		case "9":
			numButtonPress(Int(title)!)
		default:
			operButtonPress(title)
		}
	}
	
	func numButtonPress(_ n: Int) {
		if isOpPerformed {
			intLabel = 0
			isOpPerformed = false
		}
		intLabel = intLabel &* 10 &+ n
		isIntLabelChanged = true
		updMainLabel()
	}
	
	func operButtonPress(_ op: String) {
		isOpPerformed = false
		if op == "AC" {
			intLabel = 0
			clrValuesOp()
			updMainLabel()
		} else if op == "NEG" {
			intLabel = intLabel &* -1
			updMainLabel()
		} else if op == "=" {
			values.append(intLabel)
			intLabel = perfOper()
			updMainLabel()
		} else if op == "+" || op == "-" {
			if isIntLabelChanged {
				values.append(intLabel)
				if values.count > 1 {
					intLabel = perfOper()
					updMainLabel()
					values.append(intLabel)
				}
				opers.append(op)
				intLabel = 0
				isIntLabelChanged = false
			} else if opers.count != 0 {
				opers[opers.endIndex - 1] = op
			}
		} else if op == "*" || op == "/" {
			if isIntLabelChanged {
				values.append(intLabel)
				if opers.count > 0 && (opers.last == "*" || opers.last == "/") {
					intLabel = perfOper()
					updMainLabel()
					values.append(intLabel)
				}
				opers.append(op)
				intLabel = 0
				isIntLabelChanged = false
			} else if opers.count != 0 {
				opers[opers.endIndex - 1] = op
			}
		}
	}
	
	func perfOper() -> Int {
		var index = 0
		var op = ""
		var check = true
		
		while check == true {
			check = false
			for (index_t, op_t) in opers.enumerated() {
				if op_t == "*" || op_t == "/" {
					index = index_t
					op = op_t
					check = true
					break
				}
			}
			
			if check == true {
				var res = 0
				if op == "*" {
					res = values[index] &* values[index + 1]
				} else {
					if values[index + 1] == 0 {
						isZeroDevision = true
						clrValuesOp()
						return(0)
					} else {
						res = values[index] / values[index + 1]
					}
				}
				values.remove(at: index + 1)
				opers.remove(at: index)
				values[index] = res
			}
		}
		
		var res = values[0]
		if opers.count == 0 {
			clrValuesOp()
			isOpPerformed = true
			return res
		}
		
		for (index, op) in opers.enumerated() {
			if op == "+" {
				res = res &+ values[index + 1]
			} else {
				res = res &- values[index + 1]
			}
		}
		clrValuesOp()
		isOpPerformed = true
		return res
	}
	
	func clrValuesOp(){
		values.removeAll()
		opers.removeAll()
	}
	
	func updMainLabel() {
		if isZeroDevision {
			label.text = "Not a number"
			isZeroDevision = false
		} else {
			label.text = String(intLabel)
		}
	}
	
	// standard
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}


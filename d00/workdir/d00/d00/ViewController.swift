//
//  ViewController.swift
//  d00
//
//  Created by Ivan BOHUN on 2/3/20.
//  Copyright © 2020 Ivan BOHUN. All rights reserved.
//

import UIKit

extension String {
    var isNumeric : Bool {
        return Double(self) != nil
    }
}

class ViewController: UIViewController {

    var numberOnScreen : Int = 0;
    var prevNumber : Int = 0;
    var perforMath = false;
    var operation = 0;
    var notNumber = false;
    
    @IBOutlet weak var outLabel: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        if perforMath == true {
            outLabel.text = String(sender.tag - 1)
            numberOnScreen = Int(outLabel.text!)!
            perforMath = false
        }
        else {
            // TODO overflow
            if outLabel.text!.isNumeric {
                if outLabel.text == "0" || outLabel.text == "Not a number" {
                    outLabel.text = ""
                }
                outLabel.text = outLabel.text! + String(sender.tag - 1)
                numberOnScreen = Int(outLabel.text!)!
            }
            else {
                outLabel.text = String(sender.tag - 1)
                numberOnScreen = Int(outLabel.text!)!
            }
        }
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        print(String(sender.tag))
        if outLabel.text != "" && sender.tag != 11 && sender.tag != 16  && sender.tag != 17 {
            if outLabel.text!.isNumeric {
                prevNumber = Int(outLabel.text!)!
            }
            
            // TODO sum for operation by operation
            if sender.tag == 12 {
                outLabel.text = "/"
            }
            else if sender.tag == 13 {
                outLabel.text = "*"
            }
            else if sender.tag == 14 {
                outLabel.text = "-"
            }
            else if sender.tag == 15 {
                outLabel.text = "+"
            }
            
            operation = sender.tag
            perforMath = true
        }
        else if sender.tag == 16 {
            if operation == 12 {
                if numberOnScreen == 0 || prevNumber == 0{
                    outLabel.text = "Not a number"
                    prevNumber = 0
                    numberOnScreen = 0
                    operation = 0
                    perforMath = false
                }
                else {
                    outLabel.text = String(prevNumber / numberOnScreen)
                }
            }
            else if operation == 13 {
                outLabel.text = String(prevNumber * numberOnScreen)
            }
            else if operation == 14 {
                outLabel.text = String(prevNumber - numberOnScreen)
            }
            else if operation == 15 {
                outLabel.text = String(prevNumber + numberOnScreen)
            }
        }
        else if sender.tag == 17 && outLabel.text!.isNumeric {
            numberOnScreen = -Int(outLabel.text!)!
            outLabel.text = String(numberOnScreen)
        }
        else if sender.tag == 11 {
            outLabel.text = "0"
            prevNumber = 0
            numberOnScreen = 0
            operation = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


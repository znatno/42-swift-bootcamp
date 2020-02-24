//
//  LoginViewController.swift
//  d09
//
//  Created by Ivan on 15.02.2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UINavigationController {
       
    override func viewDidLoad() {
        super.viewDidLoad()

        authenticationWithTouchID()
    }
    
    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
        
        var authError: NSError?
        let reasonString = NSLocalizedString("To access the secure data", comment: "")
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { success, evaluateError in
                if evaluateError != nil {
                    guard let error = evaluateError else { return }
                    print("Failed with code \(error._code)")
                }
            }
        } else {
            guard let error = authError else { return }
            print("Failed with code \(error._code)")
            authenticationWithTouchID()
        }
    }

}

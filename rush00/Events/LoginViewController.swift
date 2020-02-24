//
//  LoginViewController.swift
//  rush00
//
//  Created by Denis ROMANICHENKO on 2/9/20.
//  Copyright © 2020 Denis ROMANICHENKO. All rights reserved.
//

import UIKit
class AlertHelper {
//  - Alert
    func showAlert(fromController controller: UIViewController, messages: String) {
        let alert = UIAlertController(title: "Error", message: messages, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}

class LoginViewController: UIViewController, UITextFieldDelegate {

//  - Images
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!

//  - Stackviews
    @IBOutlet weak var stackView: UIStackView!

//  - Text Fields
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!

//  - Login
    @IBOutlet weak var loginButton: UIButton!
    let client = Client()
    let conn:APIConnection = APIConnection()
    @IBAction func loginButtonPress(_ sender: Any) {
        let loadIcon = loadingIconStart()
        if usernameTextField.text! != "" && passwdTextField.text! != "" {
            loginUser(input: usernameTextField.text!)
            sleep(2)
            if (client.userFirstName != "") {
                self.loadLoggedInScreen()
            }
            else {
                let alert = AlertHelper()
                alert.showAlert(fromController: self, messages: "Invalid Login or Password.")
            }
        }
        else {
            let alert = AlertHelper()
            alert.showAlert(fromController: self, messages: "Empty Fields")
        }
        loadingIconStop(activityIndicator: loadIcon)
    }
	
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder()
        loginButtonPress(self)
        return true
    }
	
    func loginUser(input: String) {
        if input == "" {
            print("No username entered")
            return
        }
        else {
           print("User is \(input)")
        }

        conn.genTok{ (token) in
            print("Token is \(token)")
            self.client.getUserInfo(token: token, username: "\(input)") { firstName,lastName,login,photo,userLevel, cursusNames,cursusLevels  in
                print("User found with Firstname: \(firstName), Lastname: \(lastName), Login: \(login) Photo: \(photo) Userlevel: \(userLevel), CursusNames: \(cursusNames), CursusLevels: \(cursusLevels)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = ""
        passwdTextField.text = ""
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func loadingIconStart () -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.color = UIColor.white
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        return activityIndicator
    }

    func loadingIconStop(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
    }

    func loadLoggedInScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "LoggedInViewController") as! LoggedInViewController
        loggedInViewController.clientlogged = client
        loggedInViewController.connection = conn
        self.navigationController?.pushViewController(loggedInViewController, animated: true)
    }
}

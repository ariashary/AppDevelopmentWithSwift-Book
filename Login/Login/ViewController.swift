//
//  ViewController.swift
//  Login
//
//  Created by Muhammad Ashary on 27/09/19.
//  Copyright © 2019 M. Ashary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var forgotUsernameButton: UIButton!
    @IBOutlet var forgotPasswordButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else { return }
        switch sender {
        case forgotPasswordButton:
            segue.destination.navigationItem.title = "Forgot Password"
        case forgotUsernameButton:
            segue.destination.navigationItem.title = "Forgot Username"
        case loginButton:
            segue.destination.navigationItem.title = username.text
        default:
            print("No activity")
        }
    }
    
    @IBAction func forgotUsername(_ sender: Any) {
        performSegue(withIdentifier: "ForgottenUsernameOrPassword", sender: forgotUsernameButton)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        performSegue(withIdentifier: "ForgottenUsernameOrPassword", sender: forgotPasswordButton)
    }
    
    @IBAction func login(_ sender: Any) {
        performSegue(withIdentifier: "ForgottenUsernameOrPassword", sender: loginButton)
    }
    
    

}

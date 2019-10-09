//
//  ViewController.swift
//  Contest
//
//  Created by Muhammad Ashary on 08/10/19.
//  Copyright © 2019 M. Ashary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        if let text = emailTextField.text, !text.isEmpty {
            performSegue(withIdentifier: "GoToContest", sender: nil)
        } else {
            shakeEmailTextField()
        }
    }
    
    func shakeEmailTextField() {
        UIView.animate(withDuration: 0.1, animations: {
            let shakeRight = CGAffineTransform(translationX: 10, y: 0)
            self.emailTextField.transform = shakeRight
        }) { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                let leftShake = CGAffineTransform(translationX: -20, y: 0)
                self.emailTextField.transform = leftShake
            }, completion: { (_) in
                self.emailTextField.transform = CGAffineTransform.identity
            })
        }
    }
    
}


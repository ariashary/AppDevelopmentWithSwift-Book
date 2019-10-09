//
//  ViewController.swift
//  TrafficSegue
//
//  Created by Muhammad Ashary on 27/09/19.
//  Copyright © 2019 M. Ashary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var segueSwitch: UISwitch!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func unwindToRed(unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func yellowButtonTapped(_ sender: Any) {
        if segueSwitch.isOn {
            performSegue(withIdentifier: "Yellow", sender: nil)
        }
    }
    
    @IBAction func greenButtonTapped(_ sender: Any) {
        if segueSwitch.isOn {
            performSegue(withIdentifier: "Green", sender: nil)
        }
    }
    
    
}


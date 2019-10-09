//
//  ViewController.swift
//  CommonInputControls
//
//  Created by Muhammad Ashary on 27/01/19.
//  Copyright © 2019 Muhammad Ashary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        print("Button was tapped!")
        
        if toggle.isOn {
            print("The switch is on!")
        } else {
            print("The switch is off.")
        }
         
        print("The slider is set to \(slider.value)")
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            print("The switch is on!")
        } else {
            print("The switch is off!")
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
    }
    
    @IBAction func keyboardReturnedKeyTapped(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
        }
    }
    @IBAction func textChanged(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
        }
    }
    
    @IBAction func respondToTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        print(location)
    }
}


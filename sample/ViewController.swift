//
//  ViewController.swift
//  sample
//
//  Created by user174353 on 5/28/20.
//  Copyright © 2020 user174353. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.delegate = self
        password.delegate = self
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        print("username ",username.text!)
        print("password ", password.text!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


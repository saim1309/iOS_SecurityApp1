//
//  SignUpViewController.swift
//  sample
//
//  Created by user174075 on 6/11/20.
//  Copyright © 2020 user174353. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func validateInput(firstName: UITextField) -> Bool{
            return true
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        var validationPassed:Bool =  validateInput(firstName: firstName);
        if(validationPassed){
            print("firstName: \(firstName.text!)\nlastName: \(lastName.text!)\nemail: \(email.text!)\npassword: \(password.text!)\nconfirmpassword: \(confirmPassword.text!)");
        }
        else{
            print("Validation failed");
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        password.resignFirstResponder()
        confirmPassword.resignFirstResponder()
        email.resignFirstResponder()
        
    }
    

}


extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

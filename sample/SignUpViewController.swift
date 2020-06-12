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
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message:
        message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))

        self.present(alertController, animated: true, completion: nil)
    }
    
    func clearSignUpPage(){
        firstName.text! = "";
        lastName.text! = "";
        email.text! = "";
        password.text! = "";
        confirmPassword.text! = "";
    }
    
    func validateInput(firstNameStr: String, lastNameStr:String, emailStr:String, passwordStr:String, confirmPasswordStr:String) -> Bool{
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}";
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx);
        var emailValidation:Bool =  emailPred.evaluate(with: emailStr);
        
        if(firstNameStr == "" || lastNameStr == "" || emailStr == "" || passwordStr == "" || confirmPasswordStr == ""){
            showAlert(title: "Empty Fields",message: "All fields are mandatory");
            return false;
        }
        else if(passwordStr != confirmPasswordStr) {
            showAlert(title: "Password Mismatch",message: "Enter password should match");
            return false;
        }
        else if(passwordStr.count <= 5 && confirmPasswordStr.count <= 5){
            showAlert(title: "Password Length",message: "password length should be min 5 charecters");
            return false;
        }
        else if(!emailValidation){
            showAlert(title: "Email Validation",message: "Enter valid email address");
            return false;
        }
        else{
            return true;
        }
        
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        let firstNameStr:String = firstName.text!;
        let lastNameStr:String = lastName.text!;
        let emailStr:String = email.text!;
        let passwordStr:String = password.text!;
        let confirmPasswordStr:String = confirmPassword.text!;
        
        var validationPassed:Bool =  validateInput(firstNameStr: firstNameStr,lastNameStr: lastNameStr,emailStr: emailStr,passwordStr: passwordStr,confirmPasswordStr: confirmPasswordStr);
        
        if(validationPassed){
            print("firstName: \(firstName.text!)\nlastName: \(lastName.text!)\nemail: \(email.text!)\npassword: \(password.text!)\nconfirmpassword: \(confirmPassword.text!)");
            clearSignUpPage();
            showAlert(title: "Register Complete",message: "Go to login page to login");
            
        }
        else{
            print("Validation failed");
            showAlert(title: "Registeration Failed",message: "Please try again!");
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

//
//  SignUpViewController.swift
//  sample
//
//  Created by user174075 on 6/11/20.
//  Copyright © 2020 user174353. All rights reserved.
//

import UIKit
//creating dictionary named user. This can be used in all viewController
var users = [String:String]()
class SignUpViewController: UIViewController {

    //creating outlets to connect UITextfields to code Assistant
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assigning delegates to UITextFields
        firstName.delegate = self
        lastName.delegate = self
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        users["admin"] = "admin123";
        
        //Listening for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil);
    }//end of viewDidLoad
    
    //stop listening to keyboard events
    deinit {
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillChangeFrameNotification , object: nil)
    }
    
    //function to find the keyboard size and shifting the UI accordingly
    @objc func keyboardWillChange(notification: Notification){
        print("keyboard will show:\(notification.name.rawValue)")
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        //when keyboard is made visible changinf y origin of frame according to size of keyboard
        if(notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification){
            view.frame.origin.y = -keyboardSize.height
        }
        //when keyboard is not used changing back the frame orgin to 0
        else{
            view.frame.origin.y = 0
        }
    }
    
    
    //function to register user
    func regiterUser(username:String, password:String){
        //variable to check if user is registered
        var isAlreadyRegistered:Bool = false;
        //iterating through users dictionary
        for(key,_) in users{
            //print("Users[username]"+users[username]! ?? " No username")
            
            if(username==key){
                //email is already registered in the system
                //print("email already registered");
                isAlreadyRegistered = true;
                //using custom alert to notify user that Email is already registered
                showAlert(title: "Registeration Failed",message: "Email already registered");
                break;
            }
        }
        //it is new user and we need to register him in system
        if(isAlreadyRegistered == false){
            //adding the new user in dictionary
            users[username] = password;
            //print(users[username]!);
            //using custom alert to notify user that Registeration was Successful
            showAlert(title: "Registeration Complete",message: "Go to login page to login");
        }
        
//        for(key,value) in users{
//            print("key: \(key) and its value: \(value)");
//        }

    }
    

    //custom alert function
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message:
        message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))

        self.present(alertController, animated: true, completion: nil)
    }
    
    //function to clear signUp Page once user is successfully registered
    func clearSignUpPage(){
        firstName.text! = "";
        lastName.text! = "";
        email.text! = "";
        password.text! = "";
        confirmPassword.text! = "";
    }
    
    //function to validate all inputs from user for registeration
    func validateInput(firstNameStr: String, lastNameStr:String, emailStr:String, passwordStr:String, confirmPasswordStr:String) -> Bool{
        
        //Regex for email.
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}";
        //NSPredicate matches the input email against the regex provided above and set emailValidation variable true if found ok
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx);
        let emailValidation:Bool =  emailPred.evaluate(with: emailStr);
        
        //check all fields are filled
        if(firstNameStr == "" || lastNameStr == "" || emailStr == "" || passwordStr == "" || confirmPasswordStr == ""){
            showAlert(title: "Empty Fields",message: "All fields are mandatory");
            return false;
        }
        //both the password should match
        else if(passwordStr != confirmPasswordStr) {
            showAlert(title: "Password Mismatch",message: "Enter password should match");
            return false;
        }
        //check the lenght of passowrd (min 5 charecters)
        else if(passwordStr.count < 5 && confirmPasswordStr.count < 5){
            showAlert(title: "Password Length",message: "password length should be min 5 charecters");
            return false;
        }
        //check if email validation was successful
        else if(!emailValidation){
            showAlert(title: "Email Validation",message: "Enter valid email address");
            return false;
        }
        else{
            //user input passed all the validation
            return true;
        }
        
    }//end of validation input
    
    //IBAction function for the signUp button when pressed
    @IBAction func signupPressed(_ sender: UIButton) {
        
        //getting string value for all input fields
        let firstNameStr:String = firstName.text!;
        let lastNameStr:String = lastName.text!;
        let emailStr:String = email.text!;
        let passwordStr:String = password.text!;
        let confirmPasswordStr:String = confirmPassword.text!;
        
        //validationPassed variable stores true of input passed all validations
        var validationPassed:Bool =  validateInput(firstNameStr: firstNameStr,lastNameStr: lastNameStr,emailStr: emailStr,passwordStr: passwordStr,confirmPasswordStr: confirmPasswordStr);
        
        if(validationPassed){
            print("firstName: \(firstName.text!)\nlastName: \(lastName.text!)\nemail: \(email.text!)\npassword: \(password.text!)\nconfirmpassword: \(confirmPassword.text!)");
            
            //call register user function with email and password
            regiterUser(username: emailStr, password: passwordStr);
            
            //clear function called after successful register
            clearSignUpPage();
            //showAlert(title: "Register Complete",message: "Go to login page to login");
            
        }
        else{
            //input validation failed
            print("Validation failed");
            
            //using custom alert to notify user that Registeration failed
            showAlert(title: "Registeration Failed",message: "Please try again!");
        }
        
    }//end of function signUpPressed
    
    //function to remove keyboard when touched outside text fields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        password.resignFirstResponder()
        confirmPassword.resignFirstResponder()
        email.resignFirstResponder()
        
    }
}

//dissapears keyboard when touched outside textField
extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

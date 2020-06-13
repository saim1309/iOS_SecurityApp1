//
//  ViewController.swift
//  sample
//
//  Created by user174353 on 5/28/20.
//  Copyright © 2020 user174353. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //creating outlets to connect UITextfields to code Assistant
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    


    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //assigning delegates to UITextFields
        username.delegate = self
        password.delegate = self
        
        //Listening for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil);
        
    }//end of viewLoad
    
    
    //stop listening to keyboard events
    deinit {
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillChangeFrameNotification , object: nil)
    }
    
    //function to check if user is registerd or not
    func checkUser(username:String, password: String)->Bool{
        for(key,value) in users{
            if(username==key && password==value){
                //user is registered in the system
                return true;
            }
        }
        return false;
    }
    
    //IBAction function for login button
    @IBAction func loginPressed(_ sender: UIButton) {
        //print("username ",username.text!);
        //print("password ", password.text!);
        
        //result variable will be true of user is registered
        let result:Bool = checkUser(username: username.text!,password: password.text!)
        if(result == true){
            //user is registered
            //showAlert(title: "Login Success", message: "Cograts!")
            print("Login success")
            //    performSegue(withIdentifier: "home", sender: self)
           
        }
        else{
            //user is not registered
            showAlert(title: "Login Failed", message: "Check your email and password!")
        }
        
    }
    
    //custom alert function created
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message:
        message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))

        self.present(alertController, animated: true, completion: nil)
    }
    
    //function to remove keyboard when touched outside text fields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //keyboard goes back when touched outside
        username.resignFirstResponder()
        password.resignFirstResponder()
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
    
}
//dissapears keyboard when touched outside textField
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


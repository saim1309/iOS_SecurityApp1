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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil);
        
    }
    func checkUser(username:String, password: String)->Bool{
        for(key,value) in users{
            if(username==key && password==value){
                return true;
            }
        }
        return false;
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        print("username ",username.text!);
        print("password ", password.text!);
        let result:Bool = checkUser(username: username.text!,password: password.text!)
        if(result == true){
            //user is registered
            //showAlert(title: "Login Success", message: "Cograts!")
            print("Login success")
            //    performSegue(withIdentifier: "home", sender: self)
           
        }
        else{
            showAlert(title: "Login Failed", message: "Check your email and password!")
        }
        
    }
    
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message:
        message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))

        self.present(alertController, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillChangeFrameNotification , object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification){
        print("keyboard will show:\(notification.name.rawValue)")
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        if(notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification){
            view.frame.origin.y = -keyboardSize.height
        }
        else{
            view.frame.origin.y = 0
        }
    }
    
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


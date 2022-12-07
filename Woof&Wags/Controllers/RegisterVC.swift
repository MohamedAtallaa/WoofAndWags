//
//  RegisterVC.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 29/11/2022.
//

import UIKit

class RegisterVC: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - IBOutlets
    @IBOutlet weak private var firstNameTextField: UITextField!
    @IBOutlet weak private var lastNameTextField: UITextField!
    @IBOutlet weak private var emailTextField: UITextField!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Methods
    func registerUser() {
        UserAPI.registerNewUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!)
        { user, errorMessage in
            if let error = errorMessage {
                UIAlertController.alert(title: "Error", message: error, action1Title: "OK", action2Title: "Cancel",controller: self,handler1: nil, handler2: nil)
            } else {
                if user != nil {
                    UIAlertController.alert(title: "Register", message: "Successfully Registerd", action1Title: "Log in", action2Title: "Cancel", controller: self) {
                        self.dismiss(animated: true)
                    } handler2: { }
                }
            }
        }
    }
    
    
    // MARK: - Actions
    @IBAction func registerButtonClicked(_ sender: Any) {
        registerUser()
    }
    
    
    @IBAction func doYouHaveAccountButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}


// MARK: - Extensions

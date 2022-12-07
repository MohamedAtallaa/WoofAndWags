//
//  LoginVC.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 29/11/2022.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - IBOutlets
    @IBOutlet weak private var firstNameTextField: UITextField!
    @IBOutlet weak private var lastNameTextField: UITextField!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    func checkLoginUser() {
        UserAPI.LoginUser(firsName: firstNameTextField.text!, lastName: lastNameTextField.text!) { user, errorMessage in
            if let user = user {
                UserManager.loggedInUser = user
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTapBarVC")
                self.present(vc!, animated: true)
            }else {
                if let error = errorMessage {
                    UIAlertController.alert(title: "Error", message: error, action1Title: "Register", action2Title: "Cancel", controller: self) {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
                        self.present(vc, animated: true)
                    } handler2: { }
                }
            }
        }
    }
    
    
    // MARK: - Actions
    @IBAction func loginButtonClicked(_ sender: Any) {
        if firstNameTextField.text!.isEmpty  || lastNameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Your First Name or Last Name field is empty!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }else {
            checkLoginUser()
        }
    }
    
    @IBAction func dontHaveAnAccoutnClicked(_ sender: Any) { }
    
    @IBAction func skipButtonClicked(_ sender: Any) {}
    
}


// MARK: - Extensions

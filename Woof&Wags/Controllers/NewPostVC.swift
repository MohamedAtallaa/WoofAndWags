//
//  NewPostVC.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 02/12/2022.
//

import UIKit

class NewPostVC: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - IBOutlets
    @IBOutlet weak private var postTextTextField: UITextField!
    @IBOutlet weak private var postImageURLTextField: UITextField!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Methods
    
    
    
    // MARK: - Actions
    @IBAction func postButtonClicked(_ sender: Any) {
        if let user = UserManager.loggedInUser {
            PostAPI.addNewPost(text: postTextTextField.text!, imageURL: postImageURLTextField.text!, userId: user.id) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTapBarVC")
                self.present(vc!, animated: true)
            }
        }
    }
    
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


// MARK: - Extensions

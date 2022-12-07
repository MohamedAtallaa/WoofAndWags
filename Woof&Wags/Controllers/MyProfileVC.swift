//
//  MyProfileVC.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 30/11/2022.
//

import UIKit

class MyProfileVC: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - IBOutlets
    @IBOutlet weak private var pictureURLTextField: UITextField!
    @IBOutlet weak private var firstNameTextField: UITextField!
    @IBOutlet weak private var lastNameTextField: UITextField!
    @IBOutlet weak private var firstNameLabel: UILabel!
    @IBOutlet weak private var lastNameLabel: UILabel!
    @IBOutlet weak private var userPictureImageView: UIImageView!
    @IBOutlet weak private var updateButton: UIButton!
    @IBOutlet weak private var indicator: UIActivityIndicatorView!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - Methods
    func setupUI() {
        updateButton.layer.cornerRadius = 30
        indicator.isHidden = true
        if let user = UserManager.loggedInUser {
            firstNameLabel.text = user.firstName
            lastNameLabel.text =  user.lastName
            firstNameTextField.text = user.firstName
            lastNameTextField.text = user.lastName
            pictureURLTextField.text = user.picture
            if let image = user.picture {
                userPictureImageView.imageFromStringUrl(stringUrl: image)
            }
            userPictureImageView.makeCircularImage()
            
        }
    }
    
    func updateUserData() {
        if let user = UserManager.loggedInUser {
            indicator.isHidden = false
            indicator.startAnimating()
            updateButton.titleLabel?.isHidden = true
            UserAPI.updateUserData(id: user.id, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, picture: pictureURLTextField.text!) { result in
                
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                self.updateButton.titleLabel?.isHidden = false
                switch result {
                case .success(let updatedUser):
                    
                    self.firstNameLabel.text = updatedUser.firstName
                    self.lastNameLabel.text =  updatedUser.lastName
                    if updatedUser.picture == "" {
                        self.userPictureImageView.image = UIImage(systemName: "person")
                        
                    }else {
                        self.userPictureImageView.imageFromStringUrl(stringUrl: updatedUser.picture!)
                    }
                case .failure(let error):
                    UIAlertController.alert(title: "Error", message: "\(error)", action1Title: "Ok", action2Title: "Cancel", controller: self, handler1: nil, handler2: nil)
                }
            }
        }
    }
    
    
    // MARK: - Actions
    @IBAction func updateButtonClicked(_ sender: Any) {
        updateUserData()
    }
}

// MARK: - Extensions

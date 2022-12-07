//
//  UserProfileVC.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 28/11/2022.
//

import UIKit

class UserProfileVC: UIViewController {
    
    // MARK: - Properties
    var user: User!
    
    
    // MARK: - IBOutlets
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var emailLabel: UILabel!
    @IBOutlet weak private var phoneLabel: UILabel!
    @IBOutlet weak private var countryLabel: UILabel!
    @IBOutlet weak private var genderLabel: UILabel!
    @IBOutlet weak private var birthdayLabel: UILabel!
    @IBOutlet weak private var indicator: UIActivityIndicatorView!
    @IBOutlet weak private var userImageView: UIImageView!
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.startAnimating()
        UserAPI.getUserData(id: user.id) { user in
            
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            self.user = user
            self.setupUI()
        }
    }
    
    
    // MARK: - Methods
    func setupUI() {
        userNameLabel.text = user.firstName + " " + user.lastName
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        genderLabel.text = user.gender
        birthdayLabel.text = user.dateOfBirth
        if let location = user.location {
            countryLabel.text = location.country! + " - " + location.city!
        }
        if let image = user.picture {
            userImageView.imageFromStringUrl(stringUrl: image)
            userImageView.layer.cornerRadius = 18
            //userImageView.makeCircularImage()
        }
    }
    
    
    // MARK: - Actions
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}


// MARK: - Extensions

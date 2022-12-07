//
//  User.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 28/11/2022.
//

import Foundation

struct User:Decodable {
    
    // MARK: - Properties
    var id: String
    var firstName: String
    var lastName: String
    var picture: String?
    var email: String?
    var phone: String?
    var location: Location?
    var gender: String?
    var dateOfBirth: String?
    
}




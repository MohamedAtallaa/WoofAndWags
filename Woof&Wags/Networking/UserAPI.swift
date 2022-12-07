//
//  UserAPI.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 28/11/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol UserAdimn {
    static func getUserData(id: String, completionHandler: @escaping (User) -> ())
    static func registerNewUser(firstName: String, lastName: String, email: String, completionHandler: @escaping (User?, String?) -> ())
    static func LoginUser(firsName: String, lastName: String, completionHandler: @escaping (User? , String?) -> ())
    static func updateUserData(id: String, firstName: String, lastName: String, picture: String, completionHandler: @escaping (Result<User, Error>) -> ())
}

class UserAPI: API, UserAdimn {
    
    // MARK: - Get user data
    static func getUserData(id: String, completionHandler: @escaping (User) -> ()) {
        let url = "\(baseURL)user/\(id)"
        
        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value!)
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: jsonData.rawData())
                completionHandler(user)
            }catch {
                print(error)
            }
        }
    }
    
    
    // MARK: - Register new user
    static func registerNewUser(firstName: String, lastName: String, email: String, completionHandler: @escaping (User?, String?) -> ()) {
        let url = "\(baseURL)user/create"
        let params = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email
        ]
        
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                let jsonData = JSON(response.value!)
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(user, nil)
                }catch {
                    print(error)
                }
            case .failure(_):
                let jsonData = JSON(response.data!)
                let data = jsonData["data"]
                // Error messeges
                let firstNameErrorMessage = data["firstName"].stringValue
                let lastNameErrorMessage = data["lastName"].stringValue
                let emailErrorMessage = data["email"].stringValue
                let errorMessage = firstNameErrorMessage + "\n" + lastNameErrorMessage + "\n" + emailErrorMessage
                completionHandler(nil, errorMessage)
                
            }
        }
    }
    
    
    // MARK: - Login existing user
    static func LoginUser(firsName: String, lastName: String, completionHandler: @escaping (User? , String?) -> ()) {
        let url = "\(baseURL)user"
        let params = [ "created": "1"]
        
        AF.request(url, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                let users = try decoder.decode([User].self, from: data.rawData())
                var foundUser: User?
                for user in users {
                    // getting the first user that match the requierment
                    if user.firstName == firsName && user.lastName == lastName {
                        
                        foundUser = user
                        break
                    }
                }
                if let user = foundUser {
                    completionHandler(user, nil)
                }else {
                    completionHandler(nil, "Your First Name or Last Name doesn't match any User! If you don't have an Account, Register first")
                }
            }catch {
                print(error)
            }
        }
    }
    
    
    // MARK: Update User data
    static func updateUserData(id: String, firstName: String, lastName: String, picture: String, completionHandler: @escaping (Result<User, Error>) -> ()) {
        let url = "\(baseURL)user/\(id)"
        let params = [
            "firstName": firstName,
            "lastName": lastName,
            "picture": picture
            
        ]
        
        AF.request(url, method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                let jsonData = JSON(response.value!)
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData.rawData())
                    print(user)
                    completionHandler(.success(user))
                }catch {
                    print(error)
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}


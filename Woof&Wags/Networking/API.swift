//
//  API.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 26/11/2022.
//

import Foundation
import Alamofire

class API {
    static let baseURL = "https://dummyapi.io/data/v1/"
    static let appId = "6390fab7630bf278a0232496"
    static let headers: HTTPHeaders = ["app-id": appId]
}

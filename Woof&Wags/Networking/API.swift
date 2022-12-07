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
    static let appId = "6391164e54563c72d3926ac6"
    static let headers: HTTPHeaders = ["app-id": appId]
}

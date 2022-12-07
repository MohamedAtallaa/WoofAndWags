//
//  Comment.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 27/11/2022.
//

import Foundation

struct Comment: Decodable {
    
    // MARK: - Properties
    var id: String
    var message: String
    var owner: User
    var post: String
    var publishDate: String
    
}

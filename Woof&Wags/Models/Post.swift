//
//  Post.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 26/11/2022.
//

import Foundation

struct Post: Decodable {
    
    // MARK: - Properties
    var id: String
    var image: String
    var likes: Int
    var tags: [String]?
    var text: String
    var publishDate: String
    var owner: User
    
}

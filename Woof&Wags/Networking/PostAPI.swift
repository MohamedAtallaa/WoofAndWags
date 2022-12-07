//
//  PostsAPI.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 26/11/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol PostAdmin {
    static func getPosts(page: Int, tagId: String?, completionHandler: @escaping ([Post], Int) -> ())
    static func getComments(postId: String, completionHandler: @escaping ([Comment]) -> ())
    static func addingNewComment(postId: String, userId: String, message: String, completionHandler: @escaping () -> ())
    static func getTags(completionHandler: @escaping ([String?]) -> () )
    static func addNewPost(text: String, imageURL: String, userId: String, completionHandler: @escaping () -> ())
}

class PostAPI: API, PostAdmin {
    
    // MARK: - Get Posts
    static func getPosts(page: Int, tagId: String?, completionHandler: @escaping ([Post], Int) -> ()) {
        var url = "\(baseURL)post"
        let params = [ "page": "\(page)" ]
        if var tag = tagId {
            tag = tag.trimmingCharacters(in: .whitespaces)
            url = "\(baseURL)tag/\(tag)/post"
        }
        
        AF.request(url,parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let total = jsonData["total"].intValue
            let decoder = JSONDecoder()
            do {
                let posts = try decoder.decode([Post].self, from: data.rawData())
                completionHandler(posts, total)
            }catch {
                print(error)
            }
        }
    }
    
    
    // MARK: - Get Post comments
    static func getComments(postId: String, completionHandler: @escaping ([Comment]) -> ()) {
        let url = "\(baseURL)post/\(postId)/comment"
        
        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value!)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                let comments = try decoder.decode([Comment].self, from: data.rawData())
                completionHandler(comments)
            }catch {
                print(error)
            }
        }
    }
    
    
    // MARK: - Adding comments
    static func addingNewComment(postId: String, userId: String, message: String,  completionHandler: @escaping () -> () ) {
        let url = "\(baseURL)comment/create"
        let params = [
            "post": postId,
            "message": message,
            "owner": userId
        ]
        
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().response { response in
            switch response.result {
            case .success:
                completionHandler()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    //MARK: - Get tags
    static func getTags(completionHandler: @escaping ([String?]) -> () ) {
        let url = "\(baseURL)/tag"
        
        AF.request(url, headers: headers).responseJSON {
            response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do {
                let tags = try decoder.decode([String?].self, from: data.rawData())
                completionHandler(tags)
            } catch {
                print(error)
            }
        }
    }
    
    
    //MARK: - Add New Post
    static func addNewPost(text: String, imageURL: String, userId: String, completionHandler: @escaping () -> ()) {
        let url = "\(baseURL)post/create"
        let params = [
            "owner": userId,
            "text": text,
            "image": imageURL
        ]
        
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().response { response in
            switch response.result {
            case .success:
                completionHandler()
            case .failure(let error):
                print(error)
            }
        }
    }
        
}

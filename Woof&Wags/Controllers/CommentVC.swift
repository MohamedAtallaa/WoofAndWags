//
//  CommentVC.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 27/11/2022.
//

import UIKit

class CommentVC: UIViewController {
    
    // MARK: - Properties
    var comments: [Comment] = []
    static var id: String = ""
    
    // MARK: - IBOutlets
    @IBOutlet weak private var commentTextField: UITextField!
    @IBOutlet weak private var indecator: UIActivityIndicatorView!
    @IBOutlet weak private var noCommentsLabel: UILabel!
    @IBOutlet weak private var commentsTableView: UITableView!
    
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        
        getPostComments()
    }
    
    
    // MARK: - Methods
    func getPostComments() {
        indecator.startAnimating()
        PostAPI.getComments(postId: CommentVC.id) { comments in
            self.indecator.stopAnimating()
            self.indecator.isHidden = true
            if comments.isEmpty {
                
                self.noCommentsLabel.text = "No Comments Yet."
            }else {
                
                self.noCommentsLabel.isHidden = true
                self.comments = comments
                self.commentsTableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Actions
    @IBAction func addCommentClicked(_ sender: Any) {
        if let user = UserManager.loggedInUser {
            if commentTextField.text!.isEmpty {
                UIAlertController.alert(title: "Error", message: "Type something in comment section!", action1Title: "OK", action2Title: "Cancel", controller: self, handler1: nil, handler2: nil)
            } else {
                indecator.isHidden = false
                indecator.startAnimating()
                PostAPI.addingNewComment(postId: CommentVC.id, userId: user.id, message: commentTextField.text!) {
                    self.indecator.stopAnimating()
                    self.indecator.isHidden = true
                    self.commentTextField.text = ""
                    self.getPostComments()
                }
                
            }
        }else {
            UIAlertController.alert(title: "Error", message: "You can't add comments! please Login first!", action1Title: "Login", action2Title: "Cancel", controller: self) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
                self.present(vc!, animated: true)
            } handler2: { }
        }
    }
}


// MARK: - Extensions

// MARK: UITableViewDataSource
extension CommentVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        let comment = comments[indexPath.row]
        cell.userNameLabel.text = comment.owner.firstName + " " + comment.owner.lastName
        cell.commentTextLabel.text = comment.message
        if let imageURL = comment.owner.picture {
            cell.userImageView.imageFromStringUrl(stringUrl: imageURL)
        }
        cell.userImageView.makeCircularImage()
        return cell
    }
}


// MARK: UITableViewDelegate
extension CommentVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}





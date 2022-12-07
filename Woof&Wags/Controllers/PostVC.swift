//
//  PostVC.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 26/11/2022.
//

import UIKit

class PostVC: UIViewController {
    // MARK: - Properties
    var posts: [Post] = []
    var tag: String?
    var page = 0
    var total = 0
    
    
    // MARK: - IBOutlets
    @IBOutlet weak private var postTableView: UITableView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var welcomeSV: UIStackView!
    @IBOutlet weak private var indicator: UIActivityIndicatorView!
    @IBOutlet weak private var logButton: UIButton!
    @IBOutlet weak private var tagLabel: UILabel!
    @IBOutlet weak private var tagView: ShadowView!
    @IBOutlet weak private var closeButtonView: ShadowView!
    @IBOutlet weak private var addNewPostButton: UIButton!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(userStackViewTapped), name: NSNotification.Name("userSVTapped"), object: nil)
        
        getPosts()
        checkUser()
        controlViewsVisablity()
    }
    
    
    // MARK: - Methods
    func checkUser() {
        if let user = UserManager.loggedInUser {
            userNameLabel.text = user.firstName
        }else {
            welcomeSV.isHidden = true
            logButton.setTitle("Login", for: .normal)
            logButton.backgroundColor = .white
            logButton.layer.cornerRadius = 10
            logButton.tintColor = .systemBlue
        }
    }
    
    
    func getPosts() {
        indicator.startAnimating()
        PostAPI.getPosts(page: page, tagId: tag) { posts, total in
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            self.posts.append(contentsOf: posts)
            self.total = total
            self.postTableView.reloadData()
        }
    }
    
    
    func controlViewsVisablity() {
        addNewPostButton.layer.cornerRadius = 35
        tagView.isHidden = true
        closeButtonView.isHidden = true
        if let tag = tag {
            tagView.isHidden = false
            closeButtonView.isHidden = false
            tagView.layer.cornerRadius = 5
            tagLabel.text = tag
        }
    }
    
    
    // MARK: - Actions
    @objc func userStackViewTapped(notification: Notification) {
        if let cell = (notification.userInfo?["cell"]) as? UITableViewCell {
            if let indexPath = postTableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                let vc = storyboard?.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
                vc.user = post.owner
                present(vc, animated: true)
            }
        }
    }
    
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        if UserManager.loggedInUser != nil {
            UIAlertController.alert(title: "Alert", message: "Are You sure!", action1Title: "Yes", action2Title: "No", controller: self) {
                UserManager.loggedInUser = nil
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
                self.present(vc!, animated: true)
            } handler2: {}
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
            present(vc!, animated: true)
        }
    }
    
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        tag = nil
        tagView.isHidden = true
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainTapBarVC")
        present(vc!, animated: true)
    }
}


// MARK: - Extensions
// MARK: UITableViewDataSource
extension PostVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let currentPost = posts[indexPath.row]
        cell.userNameLabel.text = currentPost.owner.firstName + " " + currentPost.owner.lastName
        cell.postDescriptionLabel.text = currentPost.text
        cell.postImageView.imageFromStringUrl(stringUrl: currentPost.image)
        cell.userImageView.imageFromStringUrl(stringUrl: currentPost.owner.picture!)
        cell.userImageView.makeCircularImage()
        cell.creationDate.text = currentPost.publishDate
        cell.likesLabel.text = "\(currentPost.likes)"
        cell.delegate = self
        cell.postId = currentPost.id
        cell.tags = currentPost.tags ?? []
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension PostVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 580
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: PostCellDelegate
extension PostVC: PostCellDelegate {
    func postCell(_ postCell: PostCell, commentButtonTappedFor postId: String) {
        CommentVC.id = postId
        let vc = storyboard?.instantiateViewController(withIdentifier: "CommentVC") as! CommentVC
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.allowsSelection = false
        if indexPath.row == posts.count - 1 && posts.count < total {
            page += 1
            getPosts()
            
        }
    }
}



//
//  PostCell.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 26/11/2022.
//

import UIKit

class PostCell: UITableViewCell {
    
    // MARK: - Properties
    weak var delegate: PostCellDelegate?
    var postId: String?
    var tags: [String] = []
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var userStackView: UIStackView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var userSV: UIStackView! {
        didSet {
            userSV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userSVTapped)))
        }
    }
    
    @IBOutlet weak var tagCollectionView: UICollectionView! {
        didSet {
            
            tagCollectionView.delegate = self
            tagCollectionView.dataSource = self
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Add action to perform when the button is ptapped
        self.commentsButton.addTarget(self, action: #selector(commentsButtonTapped(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Actions
    @IBAction func commentsButtonTapped(_ sender: Any) {
        if let id = postId, let delegate = delegate {
            self.delegate?.postCell(self, commentButtonTappedFor: id)
        }
    }
    
    @objc func userSVTapped() {
        NotificationCenter.default.post(name: NSNotification.Name("userSVTapped"), object: nil, userInfo: ["cell": self])
    }

}

// MARK: - Extensions
extension PostCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagPostCell", for: indexPath) as! TagPostCell
        cell.tagLabel.text = tags[indexPath.row]
        
        return cell
        
    }
    
}


extension PostCell: UICollectionViewDelegate {
    
}



// MARK: - Protocols
protocol PostCellDelegate: AnyObject {
    func postCell(_ postCell: PostCell, commentButtonTappedFor postId: String)
}

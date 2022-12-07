//
//  CommentCell.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 27/11/2022.
//

import UIKit

class CommentCell: UITableViewCell {
    
    // MARK: - Properties

    
    // MARK: - IBOutlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

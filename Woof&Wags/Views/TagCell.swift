//
//  TagCell.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 30/11/2022.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    // MARK: - Properties

    
    // MARK: - IBOutlets
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var tagView: UIView! {
        didSet {
            tagView.layer.shadowColor = UIColor.gray.cgColor
            tagView.layer.shadowOpacity = 0.3
            tagView.layer.shadowOffset = CGSize(width: 0, height: 5)
            tagView.layer.shadowRadius = 5
            tagView.layer.cornerRadius = 25
        }
    }
    
}

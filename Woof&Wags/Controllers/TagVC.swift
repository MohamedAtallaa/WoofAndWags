//
//  tagsVC.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 30/11/2022.
//

import UIKit

class TagVC: UIViewController {
    
    // MARK: - Properties
    var tags: [String?] = []
    
    // MARK: - IBOutlets
    @IBOutlet weak private var tagsCollectionView: UICollectionView!
    @IBOutlet weak private var indicator: UIActivityIndicatorView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        
        getTags()
    }
    
    
    // MARK: - Methods
    func getTags() {
        indicator.startAnimating()
        PostAPI.getTags { tags in
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            self.tags = tags
            self.tagsCollectionView.reloadData()
        }
    }
    
    
    // MARK: - Actions
    
}


// MARK: - Extensions

// MARK: UITableViewDataSource
extension TagVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        cell.tagNameLabel.text = tags[indexPath.row]
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension TagVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostVC
        vc.tag = tags[indexPath.row]
        self.present(vc, animated: true)
    }
}

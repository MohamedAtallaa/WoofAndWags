//
//  UIImage+ StringUrlToImage.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 26/11/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func imageFromStringUrl(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            // to not block the UI
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    func makeCircularImage() {
        self.layer.cornerRadius = self.frame.width / 2
    }
}


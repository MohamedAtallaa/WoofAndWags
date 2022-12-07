//
//  Alert.swift
//  Dogs lovers
//
//  Created by Mohamed Atallah on 01/12/2022.
//

import Foundation
import UIKit

extension UIAlertController {
    static func alert(title: String, message: String?, action1Title: String, action2Title: String, controller: UIViewController,handler1: (() -> Void)?, handler2: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: action1Title, style: .default) { _ in
            if let handler = handler1 {
                handler()
            }
        }
        let action2 = UIAlertAction(title: action2Title, style: .default) { _ in
            if let handler = handler2 {
                handler()
            }
        }
        alert.addAction(action1)
        alert.addAction(action2)
        controller.present(alert, animated: true)
    }
}

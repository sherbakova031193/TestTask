//
//  File.swift
//  TestAPartnerBNet
//
//  Created by Елизавета Щербакова on 11.08.2020.
//  Copyright © 2020 Sсherbakova Elizaveta Nikolaevna. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, titleAction: String, action: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: titleAction, style: .default, handler: action)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

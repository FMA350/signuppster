//
//  signInterface.swift
//  signuppster
//
//  Created by Francesco Maria Moneta (BFS EUROPE) on 10/04/2019.
//  Copyright © 2019 wipro.com. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


protocol sign {
    func setSubviewsFrames()
    
    func setSubviewsProperties()
    
    func addSubviews()
    
}

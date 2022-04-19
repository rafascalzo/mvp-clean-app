//
//  UIViewControllerExtensions.swift
//  UI
//
//  Created by Rafael Scalzo on 18/04/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func hideKeyboardOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

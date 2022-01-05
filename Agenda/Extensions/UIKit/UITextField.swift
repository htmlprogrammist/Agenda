//
//  UITextField.swift
//  Agenda
//
//  Created by Егор Бадмаев on 28.12.2021.
//

import UIKit

extension UITextField {
    convenience init(keyboardType: UIKeyboardType, placeholder: String) {
        self.init()
        self.isHidden = true
        self.textAlignment = .right
        self.keyboardType = keyboardType
        self.placeholder = placeholder
        self.font = UIFont.systemFont(ofSize: 16)
        self.resignFirstResponder()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

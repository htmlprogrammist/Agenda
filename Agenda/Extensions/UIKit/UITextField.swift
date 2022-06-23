//
//  UITextField.swift
//  Agenda
//
//  Created by Егор Бадмаев on 28.12.2021.
//

import UIKit

extension UITextField {
    /// Convenience init with a lot of different properties that I need. Althouth, the only place where it is being used is `GoalTableViewCell`, but it helps me not to repeat myself (DRY)
    convenience init(keyboardType: UIKeyboardType, placeholder: String, textAlignment: NSTextAlignment = .right, borderStyle: BorderStyle) {
        self.init()
        self.isHidden = true
        self.backgroundColor = .clear
        self.textAlignment = textAlignment
        self.keyboardType = keyboardType
        self.placeholder = placeholder
        self.font = UIFont.systemFont(ofSize: 16)
        self.borderStyle = borderStyle
        self.resignFirstResponder()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

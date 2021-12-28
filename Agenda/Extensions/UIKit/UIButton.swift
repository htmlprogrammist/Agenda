//
//  UIButton.swift
//  Agenda
//
//  Created by Егор Бадмаев on 28.12.2021.
//

import UIKit

extension UIButton {
    convenience init(imageSystemName: String) {
        self.init()
        self.setImage(UIImage(systemName: imageSystemName), for: .normal)
        self.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        self.tintColor = .black
        self.layer.cornerRadius = 8
    }
}

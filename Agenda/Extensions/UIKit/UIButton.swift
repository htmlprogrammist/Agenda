//
//  UIButton.swift
//  Agenda
//
//  Created by Егор Бадмаев on 28.12.2021.
//

import UIKit

/// Кнопки из бывшего Stepper'a. Кастомного, на весь экран. 10.01.21 - ветка `stepper-v1`
/// Рано или поздно планирую всё же вернуть всё как было, поэтому не удаляю этот файл

extension UIButton {
    convenience init(type: ButtonType, imageSystemName: String) {
        self.init(type: type)
        self.setImage(UIImage(systemName: imageSystemName), for: .normal)
        self.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        self.tintColor = .black
        self.layer.cornerRadius = 8
    }
}

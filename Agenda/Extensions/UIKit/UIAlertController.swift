//
//  UIAlertController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 21.12.2021.
//

import UIKit

// MARK: this code is needed so that the console no longer displays an error about the allegedly negative width

extension UIAlertController {
    func negativeWidthConstraint() {
        for subView in self.view.subviews {
            for constraints in subView.constraints where constraints.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraints)
            }
        }
    }
}

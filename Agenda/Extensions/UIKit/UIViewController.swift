//
//  UIViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.04.2022.
//

import UIKit

extension UIViewController {
    /// Shows simple alert with the same style
    func alertForError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    /// Shows action sheet with 2 actions. It is being used in deleting goal or month. Allows you to comply with the DRY principle.
    /// - Parameters:
    ///   - title: Title for the action sheet
    ///   - message: Description to add more details for the operation
    ///   - completion: completion block that is being called when user selects _"yes"_. It contains the deletion logic when calling this method
    func alertForDeletion(title: String, message: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let yes = UIAlertAction(title: Labels.yes, style: .destructive, handler: { _ in
            completion()
        })
        let no = UIAlertAction(title: Labels.cancel, style: .default)
        
        alert.addAction(yes)
        alert.addAction(no)
        
        /// for definition try to open declaration of this functions in Extensions/UIKit/UIAlertController.swift
        alert.negativeWidthConstraint()
        present(alert, animated: true)
    }
    
    /// Allows to hide keyboard when user taps around by using `UITapGestureRecognizer` with action `dismissKeyboard` defined lower
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

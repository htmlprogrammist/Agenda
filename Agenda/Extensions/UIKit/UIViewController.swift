//
//  UIViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.04.2022.
//

import UIKit

extension UIViewController {
    
    func alertForError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertForDeletion(title: String, message: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let yes = UIAlertAction(title: Labels.yes, style: .destructive, handler: { _ in
            completion()
        })
        let no = UIAlertAction(title: Labels.cancel, style: .default)
        
        alert.addAction(yes)
        alert.addAction(no)
        
        alert.negativeWidthConstraint() // for definition try to open declaration of this functions in Extensions/UIKit/UIAlertController.swift
        present(alert, animated: true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

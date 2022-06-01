//
//  AlertError.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.04.2022.
//

import UIKit

extension UIViewController {
    
    func alertForError(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}


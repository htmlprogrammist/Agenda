//
//  String.swift
//  Agenda
//
//  Created by Егор Бадмаев on 09.04.2022.
//

import Foundation

extension String {
    /// For simplify localizing texts in the whole application
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    /// Capitalizes first letter of the string
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

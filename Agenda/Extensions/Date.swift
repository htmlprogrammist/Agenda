//
//  Date.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.04.2022.
//

import Foundation

extension Date {
    /// Format date with format `dd.MM.yyyy` to the provided template with the first capitalized letter
    func formatTo(_ template: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.setLocalizedDateFormatFromTemplate(template)
        return dateFormatter.string(from: self).capitalizingFirstLetter()
    }
}

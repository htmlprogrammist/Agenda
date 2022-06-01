//
//  Date.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.04.2022.
//

import Foundation

extension Date {
    func formatTo(_ template: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.setLocalizedDateFormatFromTemplate(template)
        return dateFormatter.string(from: self).capitalizingFirstLetter()
    }
}

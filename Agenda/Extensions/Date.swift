//
//  Date.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.04.2022.
//

import Foundation

extension Date {
    func formatToMonthYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMy")
        return dateFormatter.string(from: self).capitalizingFirstLetter()
    }
}

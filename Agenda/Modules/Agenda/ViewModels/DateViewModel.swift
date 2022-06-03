//
//  DateViewModel.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//

struct DateViewModel { // to display month info (date and progress bar in AgendaVC)
    let dayAndMonth: String
    let year: String
    let progress: Float
    
    init(dayAndMonth: String, year: Int, progress: Float) {
        self.dayAndMonth = dayAndMonth
        self.year = ", \(year)"
        self.progress = progress
    }
}

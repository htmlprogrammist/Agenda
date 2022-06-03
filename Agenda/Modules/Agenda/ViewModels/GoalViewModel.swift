//
//  GoalViewModel.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//

struct GoalViewModel { // used to provide data to cells in AgendaVC
    let name: String
    let current: String
    let aim: String
    let progress: Float
    
    init(name: String, current: Int, aim: Int) {
        self.name = name
        self.current = String(current)
        self.aim = String(aim)
        self.progress = Float(current) / Float(aim)
    }
}

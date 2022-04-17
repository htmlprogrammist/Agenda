//
//  MonthData.swift
//  Agenda
//
//  Created by Егор Бадмаев on 12.04.2022.
//

import Foundation

struct MonthData {
    let date: Date
//    let goals: [Goal]
    
    var averageNumberOfCompletedGoals: Double = 0.0
    var percentage: Double = 0.0
    var completedGoals: Double = 0.0
    var uncompletedGoals: Double = 0.0
    var allGoals: Double = 0.0
}

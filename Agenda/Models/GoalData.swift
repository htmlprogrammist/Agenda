//
//  GoalData.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.04.2022.
//

struct GoalData {
    var title: String = ""
    var current: String = ""
    var aim: String = ""
    var notes: String = ""
}

extension Goal {
    var goalData: GoalData {
        GoalData(title: name ?? "", current: String(current), aim: String(aim), notes: notes ?? "")
    }
}

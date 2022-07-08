//
//  Summary.swift
//  Agenda
//
//  Created by Егор Бадмаев on 06.04.2022.
//

import UIKit

struct Summary {
    let icon: UIImage
    let title: String
    let tintColor: UIColor
    let measure: String
    var number: Double = 0.0
    let kind: SummaryKind
    let description: String
    let isLessBetter: Bool
    let competion: (_ months: [Month]) -> Result<[(String, Double)], Error>
}

enum SummaryKind: Int {
    case percentOfSetGoals
    case completedGoals
    case uncompletedGoals
    case allGoals
}

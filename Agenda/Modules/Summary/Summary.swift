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
    
    static var summaries: [Summary] = [
        Summary(icon: Icons.grid, title: Labels.Summary.percentOfSetGoals, tintColor: .systemTeal, measure: "% \(Labels.Summary.ofSetGoals)"),
        Summary(icon: Icons.checkmark, title: Labels.Summary.completedGoals, tintColor: .systemGreen, measure: Labels.Summary.goalsDeclension),
        Summary(icon: Icons.xmark, title: Labels.Summary.uncompletedGoals, tintColor: .systemRed, measure: Labels.Summary.goalsDeclension),
        Summary(icon: Icons.sum, title: Labels.Summary.allGoals, tintColor: .systemOrange, measure: Labels.Summary.goalsDeclension)
    ]
}

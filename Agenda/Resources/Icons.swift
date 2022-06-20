//
//  Icons.swift
//  Agenda
//
//  Created by Егор Бадмаев on 14.06.2022.
//

import UIKit

enum Icons {
    // Tab bar
    static let calendar = Icon("calendar")
    static let history = Icon("clock.fill")
    static let summary = Icon("square.text.square.fill")
    
    // Summary
    static let grid = Icon("number")
    static let checkmark = Icon("checkmark")
    static let xmark = Icon("xmark")
    static let sum = Icon("sum")
    
    // Onboarding
    static let lightbulb = Icon("lightbulb")
    static let chartBarDoc = Icon("chart.bar.doc.horizontal")
    static let notesTextBadgePlus = Icon("note.text.badge.plus")
}

extension Icons {
    static func Icon(_ name: String, renderingMode: UIImage.RenderingMode = .alwaysTemplate) -> UIImage {
        return UIImage(named: name)!.withRenderingMode(renderingMode)
    }
}

//
//  GoalTableView.swift
//  Agenda
//
//  Created by Егор Бадмаев on 05.04.2022.
//

import UIKit

final class GoalTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .insetGrouped)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
    }
}


//
//  HistoryTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 18.12.2021.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    let monthDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // надо ли писать статистику? По количеству достигнтутых и поставленных целей?
    // "Цели: 3/5" (серым цветом)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        monthDateLabel.text = "November, 2021"
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        self.addSubview(monthDateLabel)
        
        NSLayoutConstraint.activate([
            monthDateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            monthDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
    }
}

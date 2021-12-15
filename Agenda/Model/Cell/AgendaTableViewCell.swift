//
//  AgendaTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 15.12.2021.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        
    }
}

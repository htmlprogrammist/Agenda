//
//  GoalDetailsTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 24.12.2021.
//

import UIKit

class GoalDetailsTableViewCell: UITableViewCell {
    
    let labelsArray = [["Title"],
                       ["Current", "", "Aim"],
                       [""]]
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView() // начиная с этого момента мы возвращаемся к кривому отображению всего
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfigure(indexPath: IndexPath) {
        cellLabel.text = labelsArray[indexPath.section][indexPath.row]
        
        if indexPath == [3, 0] {
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        }
    }
    
    func setupView() {
        contentView.addSubview(backgroundViewCell)
        contentView.addSubview(cellLabel)
        
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
//            backgroundViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            backgroundViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backgroundViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            backgroundViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            backgroundViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
            
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 16),
        ])
    }
}

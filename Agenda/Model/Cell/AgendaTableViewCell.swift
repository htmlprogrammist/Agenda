//
//  AgendaTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 15.12.2021.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {
    var goalTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let goalProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor(red: 69/255, green: 208/255, blue: 100/255, alpha: 1)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    let goalCurrentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    let goalEndLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        let labelsStackView = UIStackView(arrangedSubviews: [goalCurrentLabel, goalEndLabel])
        labelsStackView.axis = .horizontal
        labelsStackView.distribution = .equalSpacing
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(goalTextLabel)
        self.addSubview(goalProgressView)
        self.addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            goalTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            goalTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            goalProgressView.topAnchor.constraint(equalTo: goalTextLabel.bottomAnchor, constant: 10),
            goalProgressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            goalProgressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            goalProgressView.heightAnchor.constraint(equalToConstant: 4),
            
            labelsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            labelsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
}

//
//  AgendaTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 15.12.2021.
//

import UIKit

final class AgendaTableViewCell: UITableViewCell {
    
    static let identifier = "agendaCell"
    
    lazy var goalTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var goalProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor(red: 69/255, green: 208/255, blue: 100/255, alpha: 1)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    lazy var goalCurrentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    lazy var goalEndLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [goalCurrentLabel, goalEndLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(goalTextLabel)
        contentView.addSubview(goalProgressView)
        contentView.addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            goalTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            goalTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            goalProgressView.topAnchor.constraint(equalTo: goalTextLabel.bottomAnchor, constant: 8),
            goalProgressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            goalProgressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            goalProgressView.heightAnchor.constraint(equalToConstant: 5), // default: 4
            
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}

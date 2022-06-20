//
//  AgendaTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 15.12.2021.
//

import UIKit

final class AgendaTableViewCell: UITableViewCell {
    
    static let identifier = "agendaCell"
    
    private lazy var goalTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "titleLabel"
        return label
    }()
    private lazy var goalProgressView: UIProgressView = {
        let progressView = UIProgressView()
//        progressView.progressTintColor = UIColor(red: 69/255, green: 208/255, blue: 100/255, alpha: 1)
        progressView.progressTintColor = .systemGreen
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.accessibilityIdentifier = "progressView"
        return progressView
    }()
    private lazy var goalCurrentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.accessibilityIdentifier = "currentLabel"
        return label
    }()
    private lazy var goalAimLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.accessibilityIdentifier = "aimLabel"
        return label
    }()
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [goalCurrentLabel, goalAimLabel])
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
    
    private func setupView() {
        accessibilityIdentifier = "AgendaTableViewCell"
        
        contentView.addSubview(goalTextLabel)
        contentView.addSubview(goalProgressView)
        contentView.addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            goalTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            goalTextLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            goalTextLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
            goalProgressView.topAnchor.constraint(equalTo: goalTextLabel.bottomAnchor, constant: 8),
            goalProgressView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            goalProgressView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            goalProgressView.heightAnchor.constraint(equalToConstant: 5), // default: 4
            
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            labelsStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    public func configure(goal: GoalViewModel) {
        goalTextLabel.text = goal.name
        goalCurrentLabel.text = goal.current
        goalAimLabel.text = goal.aim
        goalProgressView.progress = goal.progress
    }
}

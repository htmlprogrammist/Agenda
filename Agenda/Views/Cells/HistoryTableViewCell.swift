//
//  HistoryTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 18.12.2021.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "idHistoryCell"
    
    private lazy var monthDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var detailsSubtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(month: Month) {
        monthDateLabel.text = month.date?.formatTo("MMMMy")
        
        var completedGoalsCounter = 0
        guard let goals = month.goals?.array as? [Goal] else { return }
        
        for goal in goals {
            if goal.current >= goal.aim {
                completedGoalsCounter += 1
            }
        }
        detailsSubtitle.text = "\(Labels.goals): \(completedGoalsCounter)/\(goals.count)"
    }
}

// MARK: Methods
private extension HistoryTableViewCell {
    
    func setupView() {
        cellStackView.addArrangedSubview(monthDateLabel)
        cellStackView.addArrangedSubview(detailsSubtitle)
    }
    
    func setConstraints() {
        contentView.addSubview(cellStackView)
        
        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

//
//  OnboardingTableViewHeader.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.07.2022.
//

import UIKit

final class OnboardingTableViewHeader: UITableViewHeaderFooterView {
    
    static let identifier = "onboardingHeader"
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Labels.Onboarding.welcomeLabel
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "welcomeLabel"
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let labelAttributedText = NSMutableAttributedString(string: welcomeLabel.text ?? "")
        let agendaAttributedText = NSMutableAttributedString(string: "Agenda")
        agendaAttributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemRed, range: NSRange(location: 0, length: 6))
        labelAttributedText.append(agendaAttributedText)
        welcomeLabel.attributedText = labelAttributedText
        
        contentView.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 36),
            welcomeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            welcomeLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -4)
        ])
    }
}

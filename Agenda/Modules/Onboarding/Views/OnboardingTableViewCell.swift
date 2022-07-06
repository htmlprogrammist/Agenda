//
//  OnboardingTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.04.2022.
//

import UIKit

final class OnboardingTableViewCell: UITableViewCell {
    
    static let identifier = "onboardingCell"
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemRed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "onboardingIconImageView"
        return imageView
    }()
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "onboardingLabelsStackView"
        return stackView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.accessibilityIdentifier = "onboardingTitleLabel"
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.accessibilityIdentifier = "onboardingDescriptionLabel"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViewAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewAndConstraints() {
        backgroundColor = .clear
        accessibilityIdentifier = "OnboardingTableViewCell"
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            labelsStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    public func configure(with viewModel: OnboardingViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        iconImageView.image = viewModel.image
    }
}

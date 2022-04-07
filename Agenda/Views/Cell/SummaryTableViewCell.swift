//
//  SummaryTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 05.04.2022.
//

import UIKit

final class SummaryTableViewCell: UITableViewCell {
    
    static let identifier = "summaryCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var measureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .systemGroupedBackground
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(measureLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            iconImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 1),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 2),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
            numberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            measureLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 4),
            measureLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -2),
        ])
    }
    
    public func configure(data: Summary) {
        iconImageView.image = UIImage(systemName: data.iconImagePath, withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))?.withTintColor(data.tintColor, renderingMode: .alwaysOriginal)
        titleLabel.text = data.title
        titleLabel.textColor = data.tintColor
        numberLabel.text = NSNumber(value: data.number).stringValue // to display "1" instead of "1.0"
        measureLabel.text = data.measure
    }
}

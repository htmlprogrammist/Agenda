//
//  SummaryCollectionViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 05.04.2022.
//

import UIKit

final class SummaryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "summaryCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var measureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .systemGroupedBackground
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        iconImageView.image = UIImage(named: "clock.fill")
        titleLabel.text = "Average number of completed goals"
        numberLabel.text = "7.8"
        measureLabel.text = "goals"
        
        contentView.addSubview(numberLabel)
        contentView.addSubview(measureLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 6),
            iconImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 2),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 2),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 4),
            
            numberLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -2),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 6),
            
            measureLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -4),
            measureLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 2)
        ])
    }
}

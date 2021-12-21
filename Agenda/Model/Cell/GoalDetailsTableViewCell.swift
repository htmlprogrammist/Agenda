//
//  GoalDetailsTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 21.12.2021.
//

import UIKit

class GoalDetailsTableViewCell: UITableViewCell {
    
    let labelsArray = ["Title", "Current", "", "Aim", ""]
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
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
        
        setupView()
        
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(indexPath: IndexPath) {
        cellLabel.text = labelsArray[indexPath.row]
        
        if indexPath.row == 1 {
            cellLabel.text = "3"
        }
    }
    
    func setupView() {
        contentView.addSubview(backgroundViewCell)
        contentView.addSubview(cellLabel)
        
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1),
            
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 10),
        ])
    }
}

// MARK: UITextViewDelegate
extension GoalDetailsTableViewController: UITextViewDelegate {
    // adding placeholder to the TextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Notes"
            textView.textColor = UIColor.lightGray
        }
    }
}

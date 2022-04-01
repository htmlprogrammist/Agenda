//
//  GoalTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 06.01.2022.
//

import UIKit

class GoalTableViewCell: UITableViewCell {
    
    static let identifier = "addGoalCell"
    weak var cellDelegate: SelfsizingCellDelegate?
    let labelsArray = ["Current", "Aim"]
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var titleTextField = UITextField(keyboardType: .default, placeholder: "Title", textAlignment: .left, borderStyle: .none)
    private lazy var currentTextField = UITextField(keyboardType: .numberPad, placeholder: "0", borderStyle: .roundedRect)
    private lazy var aimTextField = UITextField(keyboardType: .numberPad, placeholder: "0", borderStyle: .roundedRect)
    
    private lazy var notesTextView: UITextView = {
        let textView = UITextView()
        textView.isHidden = true
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Notes"
        textView.textColor = UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.resignFirstResponder()
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(label)
        contentView.addSubview(titleTextField)
        contentView.addSubview(notesTextView)
        contentView.addSubview(currentTextField)
        contentView.addSubview(aimTextField)
    }
    
    private func setContraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            notesTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            notesTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            notesTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            notesTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            currentTextField.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 16),
            currentTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            currentTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            aimTextField.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 16),
            aimTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            aimTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func configure(indexPath: IndexPath) {
        if indexPath == [0, 0] {
            titleTextField.isHidden = false
        }
        if indexPath == [0, 1] {
            notesTextView.isHidden = false
        }
        if indexPath == [1, 0] {
            currentTextField.isHidden = false
            label.isHidden = false
            label.text = labelsArray[indexPath.row]
        }
        if indexPath == [1, 1] {
            aimTextField.isHidden = false
            label.isHidden = false
            label.text = labelsArray[indexPath.row]
        }
    }
}

protocol SelfsizingCellDelegate: AnyObject {
    func updateHeightOfRow(_ cell: GoalTableViewCell, _ textView: UITextView)
}

// MARK: - UITextViewDelegate
extension GoalTableViewCell: UITextViewDelegate {
    // adding dynamic height to the TextView
    func textViewDidChange(_ textView: UITextView) {
        if let deletate = cellDelegate {
            deletate.updateHeightOfRow(self, textView)
        }
    }
    
    // adding placeholder to the TextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Notes"
            textView.textColor = UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1)
        }
    }
}

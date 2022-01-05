//
//  AddingGoalTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.01.2022.
//

import UIKit

class AddingGoalTableViewCell: UITableViewCell {
    
    var goal: Goal? // MARK: Add unwrapping this thing so there will be no need to use "goal?.current ?? 0" etc.
    let labelsArray = [["Title"], // 1st section
                       ["Current", "Aim"], // 2nd section
                       [""]] // 3rd section
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let titleTextField = UITextField(keyboardType: .default, placeholder: "Title")
    let currentTextField = UITextField(keyboardType: .numberPad, placeholder: "0")
    let aimTextField = UITextField(keyboardType: .numberPad, placeholder: "0")
    
    let notesTextView: UITextView = {
        let textView = UITextView()
        textView.isHidden = true
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainerInset = UIEdgeInsets(top: 4, left: 10, bottom: 10, right: 5)
        textView.text = "Notes"
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.resignFirstResponder()
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        notesTextView.delegate = self
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: cellConfigure and setting view's contstraints
extension AddingGoalTableViewCell {
    func cellConfigure(indexPath: IndexPath) {
        cellLabel.text = labelsArray[indexPath.section][indexPath.row]
        
        if indexPath == [0, 0] {
            titleTextField.isHidden = false
        }
        if indexPath == [1, 0] {
            currentTextField.isHidden = false
        }
        if indexPath == [1, 1] {
            aimTextField.isHidden = false
        }
        
        if indexPath == [2, 0] {
            if !notesTextView.text.isEmpty && notesTextView.text != "Notes" {
                notesTextView.textColor = UIColor.black
            }
            notesTextView.isHidden = false
        }
    }
    
    func setupView() {
        contentView.addSubview(backgroundViewCell)
        contentView.addSubview(cellLabel)
        
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            backgroundViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            backgroundViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 16),
        ])
        
        contentView.addSubview(titleTextField)
        contentView.addSubview(currentTextField)
        contentView.addSubview(aimTextField)
        NSLayoutConstraint.activate([
            titleTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            currentTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            currentTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            aimTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            aimTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
        // Notes
        contentView.addSubview(notesTextView)
        NSLayoutConstraint.activate([
            notesTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            notesTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            notesTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            notesTextView.heightAnchor.constraint(equalToConstant: 200),
            notesTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
    }
}

// MARK: UITextViewDelegate
 extension AddingGoalTableViewCell: UITextViewDelegate {
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

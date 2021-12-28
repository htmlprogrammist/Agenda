//
//  GoalDetailsTableViewCell.swift
//  Agenda
//
//  Created by Егор Бадмаев on 24.12.2021.
//

import UIKit

class GoalDetailsTableViewCell: UITableViewCell {
    
    var goal: Goal?
    let labelsArray = [["Title"], // 1st section
                       ["Current", "", "Aim"], // 2nd section
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
    
    let currentTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.keyboardType = .numberPad
        textField.placeholder = "0"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.resignFirstResponder()
        return textField
    }()
    
    let incrementButton = UIButton(imageSystemName: "plus")
    let decrementButton = UIButton(imageSystemName: "minus")
    let stepperStack: UIStackView = {
        let stackView = UIStackView()
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    let aimTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.keyboardType = .numberPad
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.resignFirstResponder()
        textField.placeholder = "0"
        return textField
    }()
    let notesTextView: UITextView = {
        let textView = UITextView()
        textView.isHidden = true
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.text = "Notes"
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.resignFirstResponder()
        return textView
    }()
    
    let currentStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.isHidden = true
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        notesTextView.delegate = self
        
        // MARK: Stepper
        incrementButton.addTarget(self, action: #selector(incrementButtonTapped), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decrementButtonTapped), for: .touchUpInside)
        stepperStack.distribution = .fillEqually
        stepperStack.spacing = 4
        stepperStack.layoutMargins = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        stepperStack.addArrangedSubview(decrementButton)
        stepperStack.addArrangedSubview(incrementButton)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func incrementButtonTapped() {
//        if value < goal?.aim {
//
//        }
        print("+")
    }
    @objc func decrementButtonTapped() {
        print("-")
    }
}

// MARK: cellConfigure and setting view's contstraints
extension GoalDetailsTableViewCell {
    func cellConfigure(indexPath: IndexPath) {
        cellLabel.text = labelsArray[indexPath.section][indexPath.row]
        
        if indexPath == [1, 1] {
            stepperStack.isHidden = false
        }
        
        if indexPath == [1, 2] {
            currentStepper.isHidden = false
        }
        
        if indexPath == [2, 0] {
            if let note = goal?.notes {
                notesTextView.text = note
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
        
        // MARK: Stepper
        contentView.addSubview(stepperStack)
        NSLayoutConstraint.activate([
            stepperStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
//            stepperStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
//            stepperStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            stepperStack.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            stepperStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
        
        // Notes
        contentView.addSubview(notesTextView)
        NSLayoutConstraint.activate([
            notesTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            notesTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            notesTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            notesTextView.heightAnchor.constraint(equalToConstant: 300),
            notesTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
        
        contentView.addSubview(currentStepper)
        NSLayoutConstraint.activate([
            currentStepper.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            currentStepper.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
}

// MARK: UITextViewDelegate
 extension GoalDetailsTableViewCell: UITextViewDelegate {
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

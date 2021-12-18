//
//  GoalDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 16.12.2021.
//

import UIKit

class GoalDetailsViewController: UIViewController {
    
    var goal: Goal?
    
    var goalTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let currentLabel: UILabel = {
        let label = UILabel()
        label.text = "Current"
        return label
    }()
    let aimLabel: UILabel = {
        let label = UILabel()
        label.text = "Aim"
        return label
    }()
    let goalProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor(red: 69/255, green: 208/255, blue: 100/255, alpha: 1)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    let currentTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.keyboardType = .numberPad
//        textField.clearsOnBeginEditing = true  // нужно ли?
//        textField.keyboardAppearance = .dark
        
        textField.backgroundColor = .white
        textField.borderStyle = .line
        
        return textField
    }()
    let currentStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    let aimTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.keyboardType = .numberPad
//        textField.clearsOnBeginEditing = true  // нужно ли?
//        textField.keyboardAppearance = .dark
        
        textField.backgroundColor = .white
        textField.borderStyle = .line
        
        return textField
    }()
    let noteTextView: UITextView = {
        let textView = UITextView()
        
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = CGColor(gray: 1, alpha: 1)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        goalTitleLabel.text = goal?.title
        goalProgressView.progress = Float(goal?.current ?? 0) / Float(goal?.aim ?? 1)
        currentStepper.maximumValue = Double(goal?.aim ?? 1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChangesInGoal))
        
        setConstaints()
    }
    
    @objc func saveChangesInGoal() {
        print("Saved changes")
    }
    
    func setConstaints() {
        let editingCurrentStackView = UIStackView(arrangedSubviews: [currentLabel, currentTextField])
        let editingAimStackView = UIStackView(arrangedSubviews: [aimLabel, aimTextField])
        
        view.addSubview(goalTitleLabel)
        view.addSubview(goalProgressView)
        view.addSubview(editingCurrentStackView)
        view.addSubview(currentStepper)
        view.addSubview(editingAimStackView)
        view.addSubview(noteTextView)
        
        editingCurrentStackView.translatesAutoresizingMaskIntoConstraints = false
        editingAimStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            goalTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            goalTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            goalTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            goalProgressView.topAnchor.constraint(equalTo: goalTitleLabel.bottomAnchor, constant: 10),
            goalProgressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            goalProgressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            goalProgressView.heightAnchor.constraint(equalToConstant: 8),
            
            currentTextField.widthAnchor.constraint(equalToConstant: 94),
            editingCurrentStackView.topAnchor.constraint(equalTo: goalProgressView.bottomAnchor, constant: 10),
            editingCurrentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            editingCurrentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            currentStepper.topAnchor.constraint(equalTo: editingCurrentStackView.bottomAnchor, constant: 10),
//            currentStepper.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            currentStepper.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            aimTextField.widthAnchor.constraint(equalToConstant: 94),
            editingAimStackView.topAnchor.constraint(equalTo: currentStepper.bottomAnchor, constant: 10),
            editingAimStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            editingAimStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            noteTextView.topAnchor.constraint(equalTo: editingAimStackView.bottomAnchor, constant: 10),
            noteTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            noteTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            noteTextView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

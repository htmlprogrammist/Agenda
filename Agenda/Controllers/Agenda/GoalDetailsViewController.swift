//
//  GoalDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 16.12.2021.
//

import UIKit

class GoalDetailsViewController: UIViewController {
    
    var goal: Goal?
    
    var goalTitleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .red
        textField.placeholder = "Title"
        textField.font = UIFont.systemFont(ofSize: 24, weight: .bold)
//        textField.bounds = CGRect(origin: CGPoint(x: 16, y: 8), size: CGSize(width: 150, height: 40))
        textField.frame = CGRect(x: 10, y: 10, width: 60, height: 40)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let currentLabel: UILabel = {
        let label = UILabel()
        label.text = "Current"
//        label.backgroundColor = .white
        return label
    }()
    let aimLabel: UILabel = {
        let label = UILabel()
        label.text = "Aim"
        label.backgroundColor = .white
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
        textField.placeholder = "0"
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
        textField.placeholder = "0"
//        textField.bounds = CGRect(x: 10, y: 10, width: 10, height: 5)
        return textField
    }()
    let noteTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.text = "Notes"
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 243/255, green: 242/255, blue: 248/255, alpha: 1)
        
        goalTitleTextField.text = goal?.title
        goalProgressView.progress = Float(goal?.current ?? 0) / Float(goal?.aim ?? 1)
        currentStepper.maximumValue = Double(goal?.aim ?? 1)
        noteTextView.delegate = self // adding placeholder to the TextView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChangesInGoal))
        
        setConstaints()
    }
}

extension GoalDetailsViewController {
    
    @objc func saveChangesInGoal() {
        print("Saved changes")
    }
    
    func setConstaints() {
        let editingCurrentStackView = UIStackView(arrangedSubviews: [currentLabel, currentTextField])
        let editingAimStackView = UIStackView(arrangedSubviews: [aimLabel, aimTextField])
        
        view.addSubview(goalTitleTextField)
        view.addSubview(goalProgressView)
        view.addSubview(editingCurrentStackView)
        view.addSubview(currentStepper)
        view.addSubview(editingAimStackView)
        view.addSubview(noteTextView)
        
        editingCurrentStackView.translatesAutoresizingMaskIntoConstraints = false
        editingCurrentStackView.backgroundColor = .white
        editingCurrentStackView.bounds = CGRect(x: 0, y: 0, width: 150, height: 40)
//        editingCurrentStackView.
        
        editingAimStackView.translatesAutoresizingMaskIntoConstraints = false
        editingAimStackView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            goalTitleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            goalTitleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            goalTitleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            goalProgressView.topAnchor.constraint(equalTo: goalTitleTextField.bottomAnchor, constant: 10),
            goalProgressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            goalProgressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            goalProgressView.heightAnchor.constraint(equalToConstant: 8),
            
            currentTextField.widthAnchor.constraint(equalToConstant: 94),
            editingCurrentStackView.topAnchor.constraint(equalTo: goalProgressView.bottomAnchor, constant: 10),
            editingCurrentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            editingCurrentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            editingCurrentStackView.heightAnchor.constraint(equalToConstant: 32),
            
            currentStepper.topAnchor.constraint(equalTo: editingCurrentStackView.bottomAnchor, constant: 10),
//            currentStepper.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            currentStepper.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            aimTextField.widthAnchor.constraint(equalToConstant: 94),
            editingAimStackView.topAnchor.constraint(equalTo: currentStepper.bottomAnchor, constant: 10),
            editingAimStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            editingAimStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            editingAimStackView.heightAnchor.constraint(equalToConstant: 32),
            
            noteTextView.topAnchor.constraint(equalTo: editingAimStackView.bottomAnchor, constant: 10),
            noteTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            noteTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            noteTextView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

// MARK: UITextViewDelegate
extension GoalDetailsViewController: UITextViewDelegate {
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

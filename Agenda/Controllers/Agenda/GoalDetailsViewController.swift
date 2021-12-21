//
//  GoalDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 16.12.2021.
//

import UIKit

class GoalDetailsViewController: UIViewController {
    
    var goal: Goal?
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    var goalTitleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Title"
        textField.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        textField.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        textField.insetsLayoutMarginsFromSafeArea = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        return textField
    }()
    let currentLabel: UILabel = {
        let label = UILabel()
        label.text = "Current"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    let aimLabel: UILabel = {
        let label = UILabel()
        label.text = "Aim"
        label.font = UIFont.systemFont(ofSize: 18)
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
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.resignFirstResponder()
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
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.resignFirstResponder()
        textField.placeholder = "0"
        return textField
    }()
    let noteTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.text = "Notes"
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.resignFirstResponder()
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 243/255, green: 242/255, blue: 248/255, alpha: 1)
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.safeAreaLayoutGuide.layoutFrame.height)
        
        goalTitleTextField.text = goal?.title
        goalProgressView.progress = Float(goal?.current ?? 0) / Float(goal?.aim ?? 1)
        
        currentStepper.minimumValue = 0
        currentStepper.maximumValue = Double(goal?.aim ?? 1)
        currentStepper.value = Double(goal?.current ?? 0)
        currentStepper.addTarget(self, action: #selector(stepperAction(sender:)), for: .valueChanged)
        
        currentTextField.text = String(goal?.current ?? 0)
        aimTextField.text = String(goal?.aim ?? 1)
        noteTextView.delegate = self // adding placeholder to the TextView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChangesInGoal))
        
        setupView()
    }
    
    @objc func stepperAction(sender: UIStepper) {
        goal?.current = Int(sender.value) // работает, но ничего на экране не изменяется, поэтому...
        currentTextField.text = String(Int(sender.value))
        goalProgressView.progress = Float(sender.value) / Float(goal?.aim ?? 1)
    }
    
    @objc func saveChangesInGoal() {
        print("Saved changes")
    }
}

extension GoalDetailsViewController {
    
    func setupView() {
        let headerStackView = UIStackView(arrangedSubviews: [goalTitleTextField, goalProgressView])
        let editingCurrentStackView = UIStackView(arrangedSubviews: [currentLabel, currentTextField])
        let editingAimStackView = UIStackView(arrangedSubviews: [aimLabel, aimTextField])
        view.addSubview(scrollView)
        scrollView.addSubview(headerStackView)
        scrollView.addSubview(editingCurrentStackView)
        
        scrollView.addSubview(currentStepper)
        scrollView.addSubview(editingAimStackView)
        scrollView.addSubview(noteTextView)
        
        [headerStackView, editingCurrentStackView, editingAimStackView].forEach {
            $0.isLayoutMarginsRelativeArrangement = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .white
        }
        
        headerStackView.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        headerStackView.spacing = 4
        headerStackView.axis = .vertical

        editingCurrentStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        editingAimStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            headerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            headerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            headerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            
            currentTextField.widthAnchor.constraint(equalToConstant: 94),
            editingCurrentStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
            editingCurrentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            editingCurrentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            editingCurrentStackView.heightAnchor.constraint(equalToConstant: 36),
            
            currentStepper.topAnchor.constraint(equalTo: currentLabel.bottomAnchor, constant: 10),
            currentStepper.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            aimTextField.widthAnchor.constraint(equalToConstant: 94),
            editingAimStackView.topAnchor.constraint(equalTo: currentStepper.bottomAnchor, constant: 10),
            editingAimStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            editingAimStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            editingAimStackView.heightAnchor.constraint(equalToConstant: 36),
            
            noteTextView.topAnchor.constraint(equalTo: editingAimStackView.bottomAnchor, constant: 10),
            noteTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            noteTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
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

//
//  AddGoalViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 17.12.2021.
//

import UIKit

class AddGoalViewController: UIViewController {
    
    private let coreDataManager: CoreDataManagerProtocol
    private let month: Month
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var doneBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        barButton.isEnabled = false
        return barButton
    }()
    
    private lazy var upperContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var lowerContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var separatorView2 = separatorView
    
    private lazy var titleTextField = UITextField(keyboardType: .default, placeholder: "Title", textAlignment: .left, borderStyle: .none)
    private lazy var currentTextField = UITextField(keyboardType: .numberPad, placeholder: "0", borderStyle: .roundedRect)
    private lazy var aimTextField = UITextField(keyboardType: .numberPad, placeholder: "0", borderStyle: .roundedRect)
    
    private lazy var notesTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        textView.text = "Notes"
        textView.textColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.resignFirstResponder()
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Goal"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeThisVC))
        navigationItem.rightBarButtonItem = doneBarButton
        
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        
        setupView()
        setConstraints()
    }
    
    init(month: Month, coreDataManager: CoreDataManagerProtocol) {
        self.month = month
        self.coreDataManager = coreDataManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func closeThisVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneButtonTapped() {
        let goal = Goal(context: coreDataManager.managedObjectContext)
        
        goal.name = titleTextField.text
        goal.current = Int64(currentTextField.text!) ?? 0 // this code is safe...
        goal.aim = Int64(aimTextField.text!) ?? 0 // ... because 'done bar button' is not enabled if there is no text in text fields
        
        if let notes = notesTextView.text, notes != "Notes" {
            goal.notes = notes
        }
        month.addToGoals(goal)
        dismiss(animated: true, completion: nil)
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(upperContentView)
        upperContentView.addSubview(titleTextField)
        upperContentView.addSubview(separatorView)
        upperContentView.addSubview(notesTextView)
        
        if !notesTextView.text.isEmpty && notesTextView.text != "Notes" {
            notesTextView.textColor = UIColor.black
        }
        
        scrollView.addSubview(lowerContentView)
        lowerContentView.addSubview(currentTextField)
        lowerContentView.addSubview(separatorView)
        lowerContentView.addSubview(aimTextField)
        
        [titleTextField, currentTextField, aimTextField].forEach {
            $0.delegate = self
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            upperContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            upperContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            upperContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            upperContentView.bottomAnchor.constraint(equalTo: lowerContentView.topAnchor),
            upperContentView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            
            titleTextField.topAnchor.constraint(equalTo: upperContentView.topAnchor, constant: 14),
            titleTextField.leadingAnchor.constraint(equalTo: upperContentView.leadingAnchor, constant: 16),
            separatorView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 14),
            separatorView.leadingAnchor.constraint(equalTo: upperContentView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: upperContentView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            notesTextView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 14),
            notesTextView.leadingAnchor.constraint(equalTo: upperContentView.leadingAnchor),
            notesTextView.trailingAnchor.constraint(equalTo: upperContentView.trailingAnchor),
            
            lowerContentView.topAnchor.constraint(equalTo: notesTextView.bottomAnchor, constant: 16),
            lowerContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            lowerContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            lowerContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            lowerContentView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            lowerContentView.heightAnchor.constraint(equalToConstant: 33),
            
            currentTextField.topAnchor.constraint(equalTo: notesTextView.bottomAnchor, constant: 16),
            currentTextField.trailingAnchor.constraint(equalTo: lowerContentView.trailingAnchor, constant: -16),
            separatorView2.topAnchor.constraint(equalTo: currentTextField.bottomAnchor, constant: 14),
            separatorView2.leadingAnchor.constraint(equalTo: upperContentView.leadingAnchor, constant: 16),
            separatorView2.trailingAnchor.constraint(equalTo: upperContentView.trailingAnchor),
            separatorView2.heightAnchor.constraint(equalToConstant: 1),
            aimTextField.topAnchor.constraint(equalTo: separatorView2.bottomAnchor, constant: 16),
            aimTextField.trailingAnchor.constraint(equalTo: lowerContentView.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension AddGoalViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // if all text fields are filled with smth, done has to be enabled
        if !(titleTextField.text?.isEmpty ?? true), !(currentTextField.text?.isEmpty ?? true), !(aimTextField.text?.isEmpty ?? true) {
            doneBarButton.isEnabled = true
        }
    }
}

// MARK: - UITextViewDelegate
extension AddGoalViewController: UITextViewDelegate {
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

//
//  GoalDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 16.12.2021.
//

import UIKit
import SPIndicator

final class GoalDetailsViewControllerOld: UIViewController {
    
    private let coreDataManager: CoreDataManagerProtocol
    
    public var goal: Goal!
    public lazy var goalData = goal.goalData {
        didSet {
            checkBarButtonEnabled()
        }
    }
    public weak var delegate: CoreDataManagerDelegate?
    
    private lazy var saveBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        barButton.isEnabled = false
        return barButton
    }()
    private lazy var indicatorView: SPIndicatorView = {
        let indicatorView = SPIndicatorView(title: Labels.Agenda.saved, preset: .done)
        indicatorView.presentSide = .bottom
        indicatorView.iconView?.tintColor = .systemGreen
        return indicatorView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(GoalTableViewCell.self, forCellReuseIdentifier: GoalTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        title = Labels.Agenda.details
        navigationItem.rightBarButtonItem = saveBarButton
        view.backgroundColor = .systemGroupedBackground
        
        // This methods is declared in Extensions/UIKit/UIViewController.swift
        // It allows to hide keyboard when user taps in any place
        hideKeyboardWhenTappedAround()
        
        setupViewAndConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unregisterForKeyboardNotifications()
        indicatorView.dismiss()
    }
    
    private func setupViewAndConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func saveButtonTapped() {
        view.endEditing(true)
        saveBarButton.isEnabled = false
        coreDataManager.rewriteGoal(data: goalData, in: goal)
        delegate?.reloadTableView()
        
        indicatorView.present(haptic: .success)
    }
}

// MARK: - UITableView
extension GoalDetailsViewControllerOld: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalTableViewCell.identifier, for: indexPath) as? GoalTableViewCell else {
            fatalError("Error")
        }
        cell.goal = goalData
        cell.configure(indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - Helper methods
private extension GoalDetailsViewControllerOld {
    func checkBarButtonEnabled() {
        if !goalData.title.isEmpty, !goalData.current.isEmpty, !goalData.aim.isEmpty {
            if goalData.title != goal.name || goalData.current != String(goal.current) || goalData.aim != String(goal.aim) || goalData.notes != goal.notes {
                saveBarButton.isEnabled = true
            }
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
    }
}

// MARK: - GoalTableViewCellDelegate
extension GoalDetailsViewControllerOld: GoalTableViewCellDelegate {
    func updateHeightOfRow(_ cell: GoalTableViewCell, _ textView: UITextView) {
        resize(cell, in: tableView, with: textView) // Update height of UITextView based on text's number of lines
    }
}

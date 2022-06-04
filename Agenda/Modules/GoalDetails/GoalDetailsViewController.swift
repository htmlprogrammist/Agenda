//
//  GoalDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  
//

import UIKit
import SPIndicator

final class GoalDetailsViewController: UIViewController {
    
    
    public var goal: Goal!
    public lazy var goalData = goal.goalData {
        didSet {
            checkBarButtonEnabled()
        }
    }
    
    
    private let output: GoalDetailsViewOutput
    
    private let saveBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        barButton.isEnabled = false
        return barButton
    }()
    private let indicatorView: SPIndicatorView = {
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
    
    init(output: GoalDetailsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        title = Labels.Agenda.details
//        navigationItem.rightBarButtonItem = saveBarButton
        view.backgroundColor = .systemGroupedBackground
        hidesBottomBarWhenPushed = true // TODO: test this
        
        // This methods is declared in Extensions/UIKit/UIViewController.swift
        // It allows to hide keyboard when user taps in any place
        hideKeyboardWhenTappedAround()
        
        setupViewAndConstraints()
    }
    
    deinit {
        print("deinit")
    }
}

extension GoalDetailsViewController: GoalDetailsViewInput {
}

// MARK: - UITableView
extension GoalDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalTableViewCell.identifier, for: indexPath) as? GoalTableViewCell
        else {
            fatalError("Error")
        }
        cell.goal = goalData
        cell.configure(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: Methods
private extension GoalDetailsViewController {
    
    func checkBarButtonEnabled() {
        if !goalData.title.isEmpty, !goalData.current.isEmpty, !goalData.aim.isEmpty {
            if goalData.title != goal.name || goalData.current != String(goal.current) || goalData.aim != String(goal.aim) || goalData.notes != goal.notes {
                saveBarButton.isEnabled = true
            }
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    @objc private func saveButtonTapped() {
        view.endEditing(true)
        saveBarButton.isEnabled = false
//        coreDataManager.rewriteGoal(data: goalData, in: goal)
//        delegate?.reloadTableView() // не надо!
        
//        output.saveButtonTapped()
        indicatorView.present(haptic: .success)
    }
    
    func setupViewAndConstraints() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
extension GoalDetailsViewController: GoalTableViewCellDelegate {
    func updateHeightOfRow(_ cell: GoalTableViewCell, _ textView: UITextView) {
        resize(cell, in: tableView, with: textView) // Update height of UITextView based on text's number of lines
    }
}

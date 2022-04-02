//
//  AddGoalViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 17.12.2021.
//

import UIKit

final class AddGoalViewController: UIViewController {
    
    private let coreDataManager: CoreDataManagerProtocol
    private let month: Month
    
    public var goalData: GoalData = GoalData()
    public weak var delegate: CoreDataManagerDelegate?
    
    private lazy var doneBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        barButton.isEnabled = false
        return barButton
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GoalTableViewCell.self, forCellReuseIdentifier: GoalTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Goal"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeThisVC))
        navigationItem.rightBarButtonItem = doneBarButton
        
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        
        setupViewAndConstraints()
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
        coreDataManager.createGoal(data: goalData, in: month)
        delegate?.reloadTableView()
        
        dismiss(animated: true, completion: nil)
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
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AddGoalViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        cell.configure(indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "idAgendaDetailsHeader")
        header?.backgroundColor = .clear
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 8
        default:
            return 20
        }
    }
}

extension AddGoalViewController: GoalTableViewCellDelegate {
    
    func checkBarButtonEnabled() {
        if !goalData.title.isEmpty, !goalData.current.isEmpty, !goalData.aim.isEmpty {
            doneBarButton.isEnabled = true
        } else {
            doneBarButton.isEnabled = false
        }
    }
    
    // Update height of UITextView based on string height
    func updateHeightOfRow(_ cell: GoalTableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = tableView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
            // Scoll up your textview if required
            if let thisIndexPath = tableView.indexPath(for: cell) {
                tableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}

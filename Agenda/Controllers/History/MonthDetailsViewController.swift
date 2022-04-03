//
//  MonthDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.04.2022.
//

import UIKit

final class MonthDetailsViewController: UIViewController {
    
    private let month: Month
    private let coreDataManager: CoreDataManagerProtocol
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: AgendaTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        title = month.date?.formatToMonthYear()
        view.backgroundColor = .white
        
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
extension MonthDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        month.goals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AgendaTableViewCell.identifier, for: indexPath) as? AgendaTableViewCell else {
            return AgendaTableViewCell()
        }
        guard let goal = month.goals?.object(at: indexPath.row) as? Goal else {
            fatalError("Error at casting to Goal in AgendaTableView (cellForRowAt)")
        }
        cell.configure(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let goal = month.goals?.object(at: indexPath.row) as? Goal else { return }
        let destination = GoalDetailsViewController(coreDataManager: coreDataManager)
        destination.goal = goal
        destination.delegate = self
        
        navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Editing tableView (reordering, deleting cells)
    // reordering cells
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let chosenGoal = month.goals?.object(at: sourceIndexPath.row) as? Goal else { return }
        month.removeFromGoals(at: sourceIndexPath.row)
        month.insertIntoGoals(chosenGoal, at: destinationIndexPath.row)
        coreDataManager.saveContext()
    }
    
    // deleting cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete goal", message: "Are you sure you want to delete this goal? This change cannot be undone", preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: "Yes", style: .destructive, handler: { [self] _ in
                
                guard let goal = month.goals?.object(at: indexPath.row) as? Goal else { return }
                coreDataManager.deleteGoal(goal: goal)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            let no = UIAlertAction(title: "No", style: .default)
            
            alert.addAction(yes)
            alert.addAction(no)
            
            alert.negativeWidthConstraint() // for definition try to open declaration of this functions in Extensions/UIKit/UIAlertController.swift
            present(alert, animated: true, completion: nil) // present alert to the display
        }
    }
}

extension MonthDetailsViewController: CoreDataManagerDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
}

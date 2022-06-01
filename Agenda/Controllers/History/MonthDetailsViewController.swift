//
//  MonthDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.01.2022.
//

import UIKit

final class MonthDetailsViewController: UITableViewController {
    
    private let month: Month
    private let coreDataManager: CoreDataManagerProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        title = month.date.formatTo("MMMMy")
        view.backgroundColor = .systemBackground
        
//        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = 75
        tableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: AgendaTableViewCell.identifier)
    }
    
    init(month: Month, coreDataManager: CoreDataManagerProtocol) {
        self.month = month
        self.coreDataManager = coreDataManager
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableView
extension MonthDetailsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        month.goals?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AgendaTableViewCell.identifier, for: indexPath) as? AgendaTableViewCell else {
            return AgendaTableViewCell()
        }
        guard let goal = month.goals?.object(at: indexPath.row) as? Goal else {
            fatalError("Error at casting to Goal in AgendaTableView (cellForRowAt)")
        }
        cell.configure(goal: goal)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let goal = month.goals?.object(at: indexPath.row) as? Goal else { return }
        let destination = GoalDetailsViewController(coreDataManager: coreDataManager)
        destination.goal = goal
        destination.delegate = self
        destination.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Editing tableView (reordering, deleting cells)
    // reordering cells
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let chosenGoal = month.goals?.object(at: sourceIndexPath.row) as? Goal else { return }
        coreDataManager.replaceGoal(chosenGoal, in: month, from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    // deleting cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: Labels.Agenda.deleteGoalTitle, message: Labels.Agenda.deleteGoalDescription, preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: Labels.yes, style: .destructive, handler: { [self] _ in
                
                guard let goal = month.goals?.object(at: indexPath.row) as? Goal else { return }
                coreDataManager.deleteGoal(goal: goal)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            let no = UIAlertAction(title: Labels.cancel, style: .default)
            
            alert.addAction(yes)
            alert.addAction(no)
            
            alert.negativeWidthConstraint() // for definition try to open declaration of this functions in Extensions/UIKit/UIAlertController.swift
            present(alert, animated: true)
        }
    }
}

// MARK: - CoreDataManagerDelegate
extension MonthDetailsViewController: CoreDataManagerDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
}

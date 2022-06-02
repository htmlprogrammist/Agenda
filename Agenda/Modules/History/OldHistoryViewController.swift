//
//  HistoryViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

final class HistoryViewControllerOld: UITableViewController {
    
    private weak var coreDataManager: CoreDataManager?
    private lazy var fetchedResultsController = coreDataManager?.monthsFetchedResultsController
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        title = Labels.History.title
        view.backgroundColor = .systemBackground
        
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        do {
            try fetchedResultsController?.performFetch()
            coreDataManager?.clients.append(self)
        } catch {
            alertForError(title: Labels.oopsError, message: Labels.History.fetchErrorDescription)
        }
    }
}

// MARK: - UITableView
extension HistoryViewControllerOld {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController?.sections?[section] else {
            return 0
        }
        return section.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else { return HistoryTableViewCell() }
        guard let month = fetchedResultsController?.object(at: indexPath) else { return HistoryTableViewCell() }
        cell.configure(month: month)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
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
        
        if indexPath == [0, 0] { // current month
            tabBarController?.selectedIndex = 0
        } else {
            guard let month = fetchedResultsController?.object(at: indexPath) else { return }
            // we are sure that coreDataManager is not nil
//            let destination = MonthDetailsViewController(month: month, coreDataManager: coreDataManager!)
//            navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath == [0, 0] {
            return .none
        } else {
            return .delete
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: Labels.History.deleteMonthTitle, message: Labels.History.deleteMonthDescription, preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: Labels.yes, style: .destructive, handler: { [self] _ in
                tableView.beginUpdates()
                
                guard let month = fetchedResultsController?.object(at: indexPath) else { return }
                coreDataManager?.deleteMonth(month: month)
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
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
extension HistoryViewControllerOld: CoreDataManagerDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
}

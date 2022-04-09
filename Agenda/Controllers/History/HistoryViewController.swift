//
//  HistoryViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

final class HistoryViewController: UIViewController {
    
    private weak var coreDataManager: CoreDataManager?
    private lazy var fetchedResultsController = coreDataManager?.monthsFetchedResultsController
    
    // This UIView does not allow large title to go down with table view (it look awful, because table view's and view's background colors differ)
    private lazy var separatorView = SeparatorView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        title = Labels.History.title
        view.backgroundColor = .white
        
        setupViewAndConstraints()
        
        do {
            try fetchedResultsController?.performFetch()
            coreDataManager?.clients.append(self)
        } catch {
            alertForError(title: Labels.oopsError, message: Labels.History.fetchErrorDescription)
        }
    }
}

// MARK: - Methods
extension HistoryViewController {
    
    private func setupViewAndConstraints() {
        view.addSubview(separatorView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            separatorView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: -1), // -1 is separatorView's height
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController?.sections?[section] else {
            return 0
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else { return HistoryTableViewCell() }
        guard let month = fetchedResultsController?.object(at: indexPath) else { return HistoryTableViewCell() }
        cell.configure(month: month)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
        
        if indexPath == [0, 0] { // current month
            tabBarController?.selectedIndex = 0
        } else {
            guard let month = fetchedResultsController?.object(at: indexPath) else { return }
            let destination = MonthDetailsViewController(month: month, coreDataManager: coreDataManager!)
            // we are sure that core data manager is not nil
            navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath == [0, 0] {
                alertForError(title: Labels.oopsError, message: Labels.History.currentMonthDeletion)
            } else {
                let alert = UIAlertController(title: Labels.History.deleteMonthTitle, message: Labels.History.deleteMonthDescription, preferredStyle: .actionSheet)
                let yes = UIAlertAction(title: Labels.yes, style: .destructive, handler: { [self] _ in
                    tableView.beginUpdates()
                    
                    guard let month = fetchedResultsController?.object(at: indexPath) else { return }
                    coreDataManager?.deleteMonth(month: month)
                    
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    tableView.endUpdates()
                })
                let no = UIAlertAction(title: Labels.no, style: .default)
                
                alert.addAction(yes)
                alert.addAction(no)
                
                alert.negativeWidthConstraint() // for definition try to open declaration of this functions in Extensions/UIKit/UIAlertController.swift
                present(alert, animated: true)
            }
        }
    }
}

extension HistoryViewController: CoreDataManagerDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
}

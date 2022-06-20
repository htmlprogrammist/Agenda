//
//  HistoryViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import UIKit

final class HistoryViewController: UITableViewController {
    
    private let output: HistoryViewOutput
    
    private var viewModels = [MonthViewModel]()
    
    init(output: HistoryViewOutput) {
        self.output = output
        
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        output.fetchData()
    }
}

// MARK: - ViewInput
extension HistoryViewController: HistoryViewInput {
    func showAlert(title: String, message: String) {
        alertForError(title: title, message: message)
    }
    
    func setData(viewModels: [MonthViewModel]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
}

// MARK: - UITableView
extension HistoryViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell
        else { return HistoryTableViewCell() }
        cell.configure(with: viewModels[indexPath.row])
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
            output.didSelectRow(at: indexPath)
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
            alertForDeletion(title: Labels.History.deleteMonthTitle, message: Labels.History.deleteMonthDescription) { [weak self] in
                guard let strongSelf = self else { return }
                
                strongSelf.output.deleteItem(at: indexPath)
                strongSelf.viewModels.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

// MARK: - Helper methods
private extension HistoryViewController {
    func setupView() {
        navigationItem.rightBarButtonItem = editButtonItem
        title = Labels.History.title
        view.backgroundColor = .systemBackground
        
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
    }
}

// MARK: - CoreDataManagerDelegate
extension HistoryViewController: CoreDataManagerDelegate {
    func updateViewModel() {
        output.fetchData()
    }
}

//
//  MonthDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//

import UIKit

final class MonthDetailsViewController: UITableViewController {
    
    private let output: MonthDetailsViewOutput
    
    private var viewModels = [GoalViewModel]()
    
    init(output: MonthDetailsViewOutput) {
        self.output = output
        
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        view.backgroundColor = .systemBackground
        
        tableView.rowHeight = 75
        tableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: AgendaTableViewCell.identifier)
        
        output.viewDidLoad()
    }
}

extension MonthDetailsViewController: MonthDetailsViewInput {
    func setMonthData(viewModels: [GoalViewModel], title: String) {
        self.title = title
        self.viewModels = viewModels
        tableView.reloadData()
    }
}

// MARK: - UITableView
extension MonthDetailsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AgendaTableViewCell.identifier, for: indexPath) as? AgendaTableViewCell else {
            return AgendaTableViewCell()
        }
        cell.configure(goal: viewModels[indexPath.row])
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
        output.didSelectRowAt(indexPath)
    }
    
    // MARK: Editing tableView (reordering, deleting cells)
    // reordering cells
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        output.moveRowAt(from: sourceIndexPath, to: destinationIndexPath)
    }
    
    // deleting cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: Labels.Agenda.deleteGoalTitle, message: Labels.Agenda.deleteGoalDescription, preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: Labels.yes, style: .destructive, handler: { [weak self] _ in
                guard let strongSelf = self else { return }
                
                strongSelf.output.deleteItem(at: indexPath)
                strongSelf.viewModels.remove(at: indexPath.row)
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

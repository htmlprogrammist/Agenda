//
//  GoalDetailsTableViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 24.12.2021.
//

import UIKit

class GoalDetailsTableViewController: UITableViewController {
    
    var goal: Goal?
    var idAgendaDetailsCell = "idAgendaDetailsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Details"
//        navigationController?.navigationBar.prefersLargeTitles = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        tableView.register(GoalDetailsTableViewCell.self, forCellReuseIdentifier: idAgendaDetailsCell)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 3
        case 2: return 1
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idAgendaDetailsCell, for: indexPath) as? GoalDetailsTableViewCell else { fatalError("Мистер Анджело? Мисс Ячейка (GoalDetails) передаёт вам привет") }
        cell.cellConfigure(indexPath: indexPath)
        cell.goal = goal
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let cell = tableView.cellForRow(at: indexPath) as! GoalDetailsTableViewCell
        // безопасный, по моему мнению, вариант
//        guard let cell = tableView.cellForRow(at: indexPath) as? GoalDetailsTableViewCell else { fatalError("Ошибка, я в методе didSelectFowAt")}
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

extension GoalDetailsTableViewController {
    
    func setupView() {
        
    }
}

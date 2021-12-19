//
//  HistoryViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    var idHistoryCell = "idHistoryCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "History"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: idHistoryCell)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idHistoryCell, for: indexPath) as? HistoryTableViewCell else { fatalError("Мистер Анджело? Мисс Ячейка (History) передаёт вам привет")}
        
//        let goal = goals[indexPath.row]
//        cell.goalTextLabel.text = goal.title
//        cell.goalProgressView.progress = Float(goal.current) / Float(goal.aim)
//        cell.goalCurrentLabel.text = String(goal.current)
//        cell.goalEndLabel.text = String(goal.aim)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let destination = GoalDetailsViewController()
//        destination.goal = goals[indexPath.row]
//        navigationController?.pushViewController(destination, animated: true)
    }
}

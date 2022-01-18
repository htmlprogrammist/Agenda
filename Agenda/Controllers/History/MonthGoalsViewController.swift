//
//  MonthGoalsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.01.2022.
//

import UIKit

class MonthGoalsViewController: UITableViewController {

    var idMonthGoalCell = "idMonthGoalCell"
    var goals: [Goal] = Goal.getGoals() // must be optional (var goals: [Goal]?)
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: idMonthGoalCell)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension MonthGoalsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idMonthGoalCell, for: indexPath) as? AgendaTableViewCell else { fatalError("Мистер Анджело? Мисс Ячейка (MonthGoal) передаёт вам привет")}
        
        let goal = goals[indexPath.row]
        cell.goalTextLabel.text = goal.title
        cell.goalProgressView.progress = Float(goal.current) / Float(goal.aim)
        cell.goalCurrentLabel.text = String(goal.current)
        cell.goalEndLabel.text = String(goal.aim)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
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
        let destination = GoalDetailsViewController()
        destination.goal = goals[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
}

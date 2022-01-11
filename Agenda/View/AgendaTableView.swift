//
//  AgendaTableView.swift
//  Agenda
//
//  Created by Егор Бадмаев on 08.01.2022.
//

import UIKit

class AgendaTableView: UIView {
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var idAgendaCell = "idAgendaCell"
    var goals: [Goal] = Goal.getGoals()
    
    /*
     - [ ] Перенести то, что было во viewDidLoad()
     - [ ] 
     */
    
    func setupView() {
        contentView.addSubview(tableView)
        addSubview(contentView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: idAgendaCell)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension AgendaTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idAgendaCell, for: indexPath) as? AgendaTableViewCell else { fatalError("Мистер Анджело? Мисс Ячейка передаёт вам привет")}
        
        let goal = goals[indexPath.row]
        cell.goalTextLabel.text = goal.title
        cell.goalProgressView.progress = Float(goal.current) / Float(goal.aim)
        cell.goalCurrentLabel.text = String(goal.current)
        cell.goalEndLabel.text = String(goal.aim)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destination = GoalDetailsViewController()
        destination.goal = goals[indexPath.row]
//        navigationController?.pushViewController(destination, animated: true) // Cannot find navigationController in scope
    }*/
}

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
    var idAgendaDetailsHeader = "idAgendaDetailsHeader"
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        navigationController?.navigationBar.isHidden = true
//        navigationItem.title = "Details"
//        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.register(GoalDetailsTableViewCell.self, forCellReuseIdentifier: idAgendaDetailsCell)
    }
    
    @objc func saveButtonTapped() {
        print("Save")
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idAgendaDetailsHeader)
        header?.backgroundColor = .clear
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case [2, 0]: // UITextView
            return 200 + 10 // bottom insets = 10 points
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

//
//  GoalDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 16.12.2021.
//

import UIKit

class GoalDetailsViewController: UIViewController {
    
    var goal: Goal?
    var idAgendaDetailsCell = "idAgendaDetailsCell"
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GoalTableViewCell.self, forCellReuseIdentifier: idAgendaDetailsCell)
        
        setupView()
    }
    
    @objc func saveButtonTapped() {
        print("Save")
        navigationController?.popViewController(animated: true) // нужно ли это? Скорее да, чем нет
    }
    
    func setupView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension GoalDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 2
        case 2: return 1
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idAgendaDetailsCell, for: indexPath) as? GoalTableViewCell else { fatalError("Мистер Анджело? Мисс Ячейка (GoalDetails) передаёт вам привет") }
        cell.cellConfigure(indexPath: indexPath, stepper: true)
        cell.goal = goal
//        cell.incrementButton.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
//        cell.decrementButton.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case [2, 0]: // UITextView
            return 200 + 10 // bottom insets = 10 points
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "idAgendaDetailsHeader")
        header?.backgroundColor = .clear
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 20
        }
    }
}

extension GoalDetailsViewController {
    @objc func reloadData() {
        tableView.reloadData()
    }
}

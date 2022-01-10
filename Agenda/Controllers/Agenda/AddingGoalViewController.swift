//
//  AddingGoalViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 17.12.2021.
//

import UIKit

class AddingGoalViewController: UIViewController {
    
    var goal: Goal?
    var idAgendaAddingCell = "idAgendaAddingCell"
    let labelsArray = [["Title"], // 1st section
                       ["Current", "Aim"], // 2nd section
                       [""]] // 3rd section
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let doneBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        barButton.isEnabled = false
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Goal"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeThisVC))
        navigationItem.rightBarButtonItem = doneBarButton
        // пока не заполнишь 3 обязательных поля (title, current, aim), кнопка недоступна для нажатия. 
        
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GoalTableViewCell.self, forCellReuseIdentifier: idAgendaAddingCell)
        
        setupView()
    }
    
    @objc func closeThisVC() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButtonTapped() {
        
        
        navigationController?.dismiss(animated: true, completion: nil)
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
extension AddingGoalViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idAgendaAddingCell, for: indexPath) as? GoalTableViewCell else { fatalError("Мистер Анджело? Мисс Ячейка (AddingGoal) передаёт вам привет") }
        cell.cellConfigure(indexPath: indexPath, stepper: false)
        cell.cellLabel.text = labelsArray[indexPath.section][indexPath.row]
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
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "idAgendaAddingHeader")
        header?.backgroundColor = .clear
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

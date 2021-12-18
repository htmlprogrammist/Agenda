//
//  AgendaViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

class AgendaViewController: UIViewController {
    var dayAndMonth: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    var agendaTableView: UITableView = {
        let tableView = UITableView()
//        tableView.bounces = false  // чтобы нельзя было двигать таблицу ни вверх, ни вниз. Но она прокручивается.
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var idAgendaCell = "idAgendaCell"
    var goals = Goal.getGoals()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Agenda"
        
        agendaTableView.delegate = self
        agendaTableView.dataSource = self
        agendaTableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: idAgendaCell)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(addNewGoal)),
            editButtonItem
//            UIBarButtonItem(image: UIImage(named: "line.3.horizontal.circle"), style: .plain, target: self, action: #selector(didTapEdit)), // временно выполняет ту же функцию
            
            // 2 вариант
//            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewGoal)),
//            UIBarButtonItem(image: UIImage(systemName: "text.justify"), style: .plain, target: self, action: #selector(addNewGoal)) // временно выполняет ту же функцию
//            UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(addNewGoal)), // 2-й вариант edit'а
        ]
        
        getMonthInfo()
        setConstraints()  // adding subViews of view and setting constraints
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension AgendaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = agendaTableView.dequeueReusableCell(withIdentifier: idAgendaCell, for: indexPath) as? AgendaTableViewCell else { fatalError("Мистер Анджело? Мисс Ячейка передаёт вам привет")}
        
        let goal = goals[indexPath.row]
        cell.goalTextLabel.text = goal.title
        cell.goalProgressView.progress = Float(goal.current) / Float(goal.aim)
        cell.goalCurrentLabel.text = String(goal.current)
        cell.goalEndLabel.text = String(goal.aim)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        agendaTableView.deselectRow(at: indexPath, animated: true)
        let destination = GoalDetailsViewController()
        destination.goal = goals[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Drag-n-drop moving cells
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        agendaTableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let chosenGoal = goals.remove(at: sourceIndexPath.row) // удаляем из одного места
        goals.insert(chosenGoal, at: destinationIndexPath.row) // вставляем в другое
    }
}

extension AgendaViewController {
    func getMonthInfo() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let calendar = Calendar.current
        let days = calendar.range(of: .day, in: .month, for: date)!.count
        let arrayOfElements = dateFormatter.string(from: date).split(separator: ",")
        
        dayAndMonth.attributedText = NSAttributedString(string: "\(arrayOfElements[0]),", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)])
        yearLabel.attributedText = NSAttributedString(string: String(arrayOfElements[1]), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)])
        progressView.progress = Float(calendar.dateComponents([.day], from: date).day!) / Float(days)
    }
    
    @objc func addNewGoal() {
        let destination = AddingGoalViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func setConstraints() {
        view.addSubview(progressView)
        view.addSubview(dayAndMonth)
        view.addSubview(yearLabel)
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            dayAndMonth.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 1),
            dayAndMonth.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            yearLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 2),
            yearLabel.leadingAnchor.constraint(equalTo: dayAndMonth.trailingAnchor, constant: 0),
        ])
        
        view.addSubview(agendaTableView)
        NSLayoutConstraint.activate([
            agendaTableView.topAnchor.constraint(equalTo: dayAndMonth.bottomAnchor, constant: 10),
            agendaTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            agendaTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            agendaTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

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
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var idAgendaCell = "idAgendaCell"
    var goals: [Goal] = Goal.getGoals() // must be optional (var goals: [Goal]?)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Agenda"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: idAgendaCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewGoal))
        navigationItem.leftBarButtonItem = editButtonItem
        
        getMonthInfo()
        setupView()  // adding subViews of view and setting constraints
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension AgendaViewController: UITableViewDelegate, UITableViewDataSource {
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
        return 75
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destination = GoalDetailsViewController()
        destination.goal = goals[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Editing tableView (moving, deleting cells)
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let chosenGoal = goals.remove(at: sourceIndexPath.row) // удаляем из одного места
        goals.insert(chosenGoal, at: destinationIndexPath.row) // вставляем в другое
    }
    
    // deleting cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Delete")
//            let alert = UIAlertController(title: "Delete Note", message: "Are you sure you want to delete this note?", preferredStyle: .actionSheet)
//
//            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {
//                (alert:UIAlertAction!) in
//                //****//
////                 your code to delete item from parse.
//                // ***//
//                 //And then remove object from tableview
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//            }))
//            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
//
//            self.present(alert, animated: true, completion: nil)
            let alert = UIAlertController(title: "Delete goal", message: "Are you sure you want to delete this goal?", preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: "Yes", style: .default, handler: { action in
                print("Yes")
//                self.goals.remove(at: indexPath.row)
//                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .automatic)
//                self.agendaTableView.deleteRowsAtIndexPaths([NSIndexPath(forItem: indexPath, inSection: 0)], withRowAnimation: nil)
//                self.agendaTableView.deleteRows(at: [indexPath], with: .automatic)
                self.setEditing(false, animated: true)
            })
            let no = UIAlertAction(title: "No", style: .default) { _ in self.setEditing(false, animated: true) }
            
            alert.addAction(yes)
            alert.addAction(no)
            
            alert.negativeWidthConstraint() // for definition try to open declaration of this functions in Extensions/
            present(alert, animated: true, completion: nil)
        }
    }


//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        self.dataSource.removeAtIndex(myIndex) // dataSource Начало массива
//        self.tableview!.reloadData()
//        tableView.deleteRowsAtIndexPaths([indexPath.row], withRowAnimation: .automatic)
//    }
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
        let destination = UINavigationController(rootViewController: AddingGoalViewController())
        navigationController?.present(destination, animated: true, completion: nil)
    }
    
    func setupView() {
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
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: dayAndMonth.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

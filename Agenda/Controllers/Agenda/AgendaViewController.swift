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
//    var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
    
//    let aTableView = AgendaTableView()
//    var goals = aTableView.goals
//    let tableView = aTableView.tableView
    
    let tableView: UITableView = {
        let aTableView = AgendaTableView()
        aTableView.translatesAutoresizingMaskIntoConstraints = false
        return aTableView.tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Agenda"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewGoal))
        navigationItem.leftBarButtonItem = editButtonItem
        
        getMonthInfo()
        setupView()  // adding subViews of view and setting constraints
    }
}

// MARK: TableView
extension AgendaViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destination = GoalDetailsViewController()
        destination.goal = goals[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Editing tableView (moving, deleting cells)
    // moving cell (goal)
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let chosenGoal = goals.remove(at: sourceIndexPath.row) // удаляем из одного места
        goals.insert(chosenGoal, at: destinationIndexPath.row) // вставляем в другое
    }
    
    // deleting cell (goal)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete goal", message: "Are you sure you want to delete this goal?", preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: "Yes", style: .destructive, handler: { action in
                self.goals.remove(at: indexPath.row)
                self.tableView.reloadData()
//                self.tableView.reloadRows(at: indexPath, with: .fade) // NSException
                // MARK: Надо ли выходить из режима редактирования? Просто анимации нет, в этом проблема.
//                self.setEditing(false, animated: true) // turn off editing mode
            })
            let no = UIAlertAction(title: "No", style: .default) { _ in self.setEditing(false, animated: true) } // turn off editing mode
            
            alert.addAction(yes)
            alert.addAction(no)
            
            alert.negativeWidthConstraint() // for definition try to open declaration of this functions in Extensions/
            present(alert, animated: true, completion: nil) // present alert to the display
        }
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
            progressView.heightAnchor.constraint(equalToConstant: 4), // default: 4
            
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

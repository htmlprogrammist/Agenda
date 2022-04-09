//
//  SummaryViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

final class SummaryViewController: UIViewController {
    
    private weak var coreDataManager: CoreDataManager?
    private lazy var fetchedResultsController = coreDataManager?.monthsFetchedResultsController
    private var months: [Month]! // set only after the first fetch, used only after the setting
    
    private let imagePaths = ["number", "checkmark.square", "xmark.square", "sum"]
    private let titleLabelsText = [Labels.Summary.averageNumberOfCompletedGoals, Labels.Summary.completedGoals, Labels.Summary.uncompletedGoals, Labels.Summary.allGoals]
    private let tintColors: [UIColor] = [.systemTeal, .systemGreen, .systemRed, .systemOrange]
    private let measureLabelsText = [Labels.Summary.goalsDeclension, Labels.Summary.goalsDeclension, Labels.Summary.goalsDeclension, Labels.Summary.goalsDeclension]
    private var numbers = [0.0, 0.0, 0.0, 0.0]
    
    // This UIView does not allow large title to go down with table view (it look awful, because table view's and view's background colors differ)
    private lazy var separatorView = SeparatorView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 0
        tableView.register(SummaryTableViewCell.self, forCellReuseIdentifier: SummaryTableViewCell.identifier)
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = Labels.Summary.title
        
        setupView()
        setConstraints()
        
        do {
            try fetchedResultsController?.performFetch()
            coreDataManager?.clients.append(self) // add vc to clients to update when NSFetchedResultsController update
        } catch {
            alertForError(title: Labels.oopsError, message: Labels.Summary.fetchErrorDescription)
        }
        
        if let months = fetchedResultsController?.fetchedObjects {
            self.months = months
            countGoals(months: months)
        }
    }
    
    private func setupView() {
        view.addSubview(separatorView)
        view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            separatorView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: -1), // 1 is separatorView's height
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func countGoals(months: [Month]) {
        var completedGoalsCounter = 0
        var uncompletedGoalsCounter = 0
        var allGoalsCounter = 0
        let formattedNumber: Double
        
        for month in months {
            guard let goals = month.goals?.array as? [Goal] else { return }
            for goal in goals {
                if goal.current >= goal.aim {
                    completedGoalsCounter += 1
                } else {
                    uncompletedGoalsCounter += 1
                }
                allGoalsCounter += 1
            }
        }
        if allGoalsCounter > 0 {
            formattedNumber = Double(round(10 * Double(completedGoalsCounter) / Double(allGoalsCounter)) / 10)
        } else {
            formattedNumber = 0
        }
        numbers[0] = formattedNumber
        numbers[1] = Double(completedGoalsCounter)
        numbers[2] = Double(uncompletedGoalsCounter)
        numbers[3] = Double(allGoalsCounter)
    }
}

// MARK: UITableView
extension SummaryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier, for: indexPath) as? SummaryTableViewCell else {
            fatalError("Could not create SummaryTableViewCell")
        }
        let summary = Summary(iconImagePath: imagePaths[indexPath.section], title: titleLabelsText[indexPath.section], tintColor: tintColors[indexPath.section], number: numbers[indexPath.section], measure: measureLabelsText[indexPath.section])
        cell.configure(data: summary)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        " " // for correct displaying (table view gets from the top too much)
    }
}

extension SummaryViewController: CoreDataManagerDelegate {
    func reloadTableView() {
        countGoals(months: months)
        tableView.reloadData()
    }
}

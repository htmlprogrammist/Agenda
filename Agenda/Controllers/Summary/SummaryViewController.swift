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
    
    private var monthsData = [MonthData]()
    private lazy var monthNames = monthsData.map { $0.date.formatTo("MMMy") }
    private lazy var data: [[Double]] = [
        monthsData.map { $0.averageNumberOfCompletedGoals },
        monthsData.map { $0.completedGoals },
        monthsData.map { $0.uncompletedGoals },
        monthsData.map { $0.allGoals },
    ]
    
    private let imagePaths = ["number", "checkmark", "xmark", "sum"]
    private let titleLabelsText = [Labels.Summary.averageNumberOfCompletedGoals, Labels.Summary.completedGoals, Labels.Summary.uncompletedGoals, Labels.Summary.allGoals]
    private let tintColors: [UIColor] = [.systemTeal, .systemGreen, .systemRed, .systemOrange]
    private let measureLabelsText = [Labels.Summary.goalsDeclension, Labels.Summary.goalsDeclension, Labels.Summary.goalsDeclension, Labels.Summary.goalsDeclension]
    private var numbers = [0.0, 0.0, 0.0, 0.0] // to display in cells in Summary VC
    
    // This UIView does not allow large title to go down with table view (it look awful, because table view's and view's background colors differ)
    private lazy var separatorView = SeparatorView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 0
        tableView.register(SummaryTableViewCell.self, forCellReuseIdentifier: SummaryTableViewCell.identifier)
        
        // I think, for header it's better to read this article: https://medium.com/@shadberrow/sticky-header-in-uitableview-62621b6fc1af
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
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
        var completedGoalsCounter = 0.0
        var uncompletedGoalsCounter = 0.0
        var allGoalsCounter = 0.0
        var average = 0.0
        monthsData = []
        
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
            
            if allGoalsCounter > 0 {
                average = Double(round(10 * Double(completedGoalsCounter) / Double(allGoalsCounter)) / 10)
            }
            // every month has a date, that is why we use force-unwrap
            monthsData.append(MonthData(date: month.date, averageNumberOfCompletedGoals: average, completedGoals: completedGoalsCounter, uncompletedGoals: uncompletedGoalsCounter, allGoals: allGoalsCounter))
        }
        
        numbers[0] = average
        numbers[1] = Double(completedGoalsCounter)
        numbers[2] = Double(uncompletedGoalsCounter)
        numbers[3] = Double(allGoalsCounter)
    }
}

// MARK: - UITableView
extension SummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destination = ChartsViewController(monthNames: monthNames, values: data[indexPath.section], name: titleLabelsText[indexPath.section], tintColor: tintColors[indexPath.section])
        navigationController?.pushViewController(destination, animated: true)
    }
}

// MARK: - CoreDataManagerDelegate
extension SummaryViewController: CoreDataManagerDelegate {
    func reloadTableView() {
        countGoals(months: months)
        tableView.reloadData()
    }
}

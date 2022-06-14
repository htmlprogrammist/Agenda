//
//  AgendaViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//  

import UIKit

final class AgendaViewController: UIViewController {
	
    private let output: AgendaViewOutput
    private var viewModels = [GoalViewModel]()
    
    public let isAgenda: Bool // depending on this property, month data is displayed

    private let dayAndMonth: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let monthProgressView: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    private let separatorView = SeparatorView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 75
        tableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: AgendaTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(output: AgendaViewOutput, isAgenda: Bool) {
        self.output = output
        self.isAgenda = isAgenda
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output.fetchData() // in month details mode there is no possibility to update view models, so fetching data is now here
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        output.checkForOnboarding()
    }
}

// MARK: - AgendaViewInput
extension AgendaViewController: AgendaViewInput {
    func setMonthData(viewModels: [GoalViewModel], monthInfo: DateViewModel, title: String) {
        self.viewModels = viewModels
        
        if isAgenda {
            navigationItem.title = "Agenda"
            dayAndMonth.text = monthInfo.dayAndMonth
            yearLabel.text = monthInfo.year
            monthProgressView.progress = monthInfo.progress
        } else { // MonthDetails, which is called from History
            navigationItem.title = title
        }
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        alertForError(title: title, message: message)
    }
}

// MARK: - Helper methods
private extension AgendaViewController {
    @objc func addNewGoal() {
        output.addNewGoal()
    }
    
    func setupView() {
        if isAgenda {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewGoal))
            navigationItem.leftBarButtonItem = editButtonItem
            
            view.addSubview(monthProgressView)
            view.addSubview(dayAndMonth)
            view.addSubview(yearLabel)
        } else {
            navigationItem.rightBarButtonItem = editButtonItem
        }
        view.addSubview(separatorView)
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
    }
    
    func setConstraints() {
        if isAgenda {
            NSLayoutConstraint.activate([
                monthProgressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                monthProgressView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                monthProgressView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                monthProgressView.heightAnchor.constraint(equalToConstant: 4), // for correct displaying in iOS 13
                
                dayAndMonth.topAnchor.constraint(equalTo: monthProgressView.bottomAnchor, constant: 1),
                dayAndMonth.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                yearLabel.topAnchor.constraint(equalTo: monthProgressView.bottomAnchor, constant: 1),
                yearLabel.leadingAnchor.constraint(equalTo: dayAndMonth.trailingAnchor, constant: 0),
                
                separatorView.topAnchor.constraint(equalTo: dayAndMonth.bottomAnchor, constant: 10),
            ])
        } else {
            NSLayoutConstraint.activate([
                separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ])
        }
        NSLayoutConstraint.activate([
            separatorView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: -1), // -1 is separatorView's height
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AgendaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AgendaTableViewCell.identifier, for: indexPath) as? AgendaTableViewCell
        else { return AgendaTableViewCell() }
        cell.configure(goal: viewModels[indexPath.row])
        return cell
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
        output.didSelectRow(at: indexPath)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        output.moveRow(from: sourceIndexPath, to: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alertForDeletion(title: Labels.Agenda.deleteGoalTitle, message: Labels.Agenda.deleteGoalDescription) { [weak self] in
                guard let strongSelf = self else { return }
                
                strongSelf.output.deleteItem(at: indexPath)
                strongSelf.viewModels.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

// MARK: - CoreDataManagerDelegate
extension AgendaViewController: CoreDataManagerDelegate {
    func updateViewModel() {
        output.fetchData()
    }
}

//
//  AgendaViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

final class AgendaViewController: UIViewController {
    
    private let coreDataManager: CoreDataManagerProtocol
    private var month: Month!
    
    private lazy var dayAndMonth: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var monthProgressView: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    private lazy var separatorView = SeparatorView()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Agenda"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewGoal))
        navigationItem.leftBarButtonItem = editButtonItem
        
        month = coreDataManager.fetchCurrentMonth()
        getMonthInfo()
        
        setupView()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDefaults.standard.hasOnboarded {
            let onboarding = OnboardingViewController()
            onboarding.isModalInPresentation = true
            present(onboarding, animated: true)
        }
    }
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods
private extension AgendaViewController {
    
    func setupView() {
        view.addSubview(monthProgressView)
        view.addSubview(dayAndMonth)
        view.addSubview(yearLabel)
        view.addSubview(separatorView)
        
        view.addSubview(tableView)
    }
    
    func setConstraints() {
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
            separatorView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: -1), // -1 is separatorView's height
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func getMonthInfo() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM d")
        
        let calendar = Calendar.current
        let days = calendar.range(of: .day, in: .month, for: date)!.count // all days in current month
        
        dayAndMonth.text = dateFormatter.string(from: date)
        yearLabel.text = ", \(calendar.dateComponents([.year], from: date).year ?? 0)"
        monthProgressView.progress = Float(calendar.dateComponents([.day], from: date).day!) / Float(days)
    }
    
    @objc func addNewGoal() {
        let destination = AddGoalViewController(month: month, coreDataManager: coreDataManager)
        destination.delegate = self
        present(UINavigationController(rootViewController: destination), animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AgendaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        month.goals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AgendaTableViewCell.identifier, for: indexPath) as? AgendaTableViewCell else {
            return AgendaTableViewCell()
        }
        guard let goal = month.goals?.object(at: indexPath.row) as? Goal else {
            fatalError("Error at casting to Goal in AgendaTableView (cellForRowAt)")
        }
        cell.configure(goal: goal)
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
        
        guard let goal = month.goals?.object(at: indexPath.row) as? Goal else { return }
        let destination = GoalDetailsViewController(coreDataManager: coreDataManager)
        destination.goal = goal
        destination.delegate = self
        destination.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Editing tableView (reordering, deleting cells)
    // reordering cells
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let chosenGoal = month.goals?.object(at: sourceIndexPath.row) as? Goal else { return }
        coreDataManager.replaceGoal(chosenGoal, in: month, from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    // deleting cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: Labels.Agenda.deleteGoalTitle, message: Labels.Agenda.deleteGoalDescription, preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: Labels.yes, style: .destructive, handler: { [self] _ in
                
                guard let goal = month.goals?.object(at: indexPath.row) as? Goal else { return }
                coreDataManager.deleteGoal(goal: goal)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            let no = UIAlertAction(title: Labels.cancel, style: .default)
            no.setValue(UIColor.systemBlue, forKey: "titleTextColor")
            
            alert.addAction(yes)
            alert.addAction(no)
            
            alert.negativeWidthConstraint() // for definition try to open declaration of this functions in Extensions/UIKit/UIAlertController.swift
            present(alert, animated: true)
        }
    }
}

extension AgendaViewController: CoreDataManagerDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
}

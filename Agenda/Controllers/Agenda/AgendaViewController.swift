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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var monthProgressView: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AgendaTableViewCell.self, forCellReuseIdentifier: AgendaTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Agenda"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewGoal))
        navigationItem.leftBarButtonItem = editButtonItem
        
        month = coreDataManager.fetchCurrentMonth()
        setupView() // adding subViews of view and setting constraints
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getMonthInfo()
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
            monthProgressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            monthProgressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            monthProgressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            monthProgressView.heightAnchor.constraint(equalToConstant: 4), // default: 4
            
            dayAndMonth.topAnchor.constraint(equalTo: monthProgressView.bottomAnchor, constant: 1),
            dayAndMonth.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            yearLabel.topAnchor.constraint(equalTo: monthProgressView.bottomAnchor, constant: 2),
            yearLabel.leadingAnchor.constraint(equalTo: dayAndMonth.trailingAnchor, constant: 0),
            
            separatorView.topAnchor.constraint(equalTo: dayAndMonth.bottomAnchor, constant: 10),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
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
        monthProgressView.progress = Float(calendar.dateComponents([.day], from: date).day!) / Float(days)
    }
    
    @objc func addNewGoal() {
        let destination = UINavigationController(rootViewController: AddGoalViewController(month: month, coreDataManager: coreDataManager))
//        let destination = AddGoalViewController(month: month, coreDataManager: coreDataManager)
        present(destination, animated: true)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

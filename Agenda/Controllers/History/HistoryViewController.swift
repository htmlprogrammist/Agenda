//
//  HistoryViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    // MARK: Мысли:
    /*
     Надо переделать в UIViewController, и так же, как и в Agenda, сверху, под Title'ом будет DatePicker, чтобы сразу выбрать месяц и год, и открыть новый экран (Как AgendaViewController), который будет показывать всё по этому месяцу, как сейчас AgendaViewController показывает текущий
     От AgendaViewController нам нужен только tableView с ячейками. Ни UIBarButtonItems, ни прогресс-вью с лейблом даты. А в title можно передать тот месяц и год, который сейчас открыт
     */
    
    var idHistoryCell = "idHistoryCell"
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "History"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: idHistoryCell)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idHistoryCell, for: indexPath) as? HistoryTableViewCell else { fatalError("Мистер Анджело? Мисс Ячейка (History) передаёт вам привет")}
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let destination = GoalDetailsViewController()
//        destination.goal = goals[indexPath.row]
//        navigationController?.pushViewController(destination, animated: true)
    }
}

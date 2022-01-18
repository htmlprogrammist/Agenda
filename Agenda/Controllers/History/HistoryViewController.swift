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
     Если я научусь всё-таки передавать tableView со всеми настройками в Custom View: UIVIew каком-нибудь, то будет вообще здорово. Эта фишка нужна здесь, и в AddingGoal & GoalDetails
     */
//    var data = ["November, 2021", "December, 2021", "January, 2022", "February, 2022"] // MARK: (1)
    var data: [String] = []
    var idHistoryCell = "idHistoryCell"
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
//    var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
    let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Information on previous months will be reflected here."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.isHidden = true
        return label
    }()
//    let infoImage: UIImage = {
//        let image = UIImage(systemName: "archivebox")
//        return image
//    }()
    
//    let infoImage = UIImage(systemName: "archivebox")
//    let infoStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.spacing = 10
//        stackView.axis = .vertical
//        return stackView
//    }()
    
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
        
//        infoStackView.addArrangedSubview(infoLabel)
//        infoStackView.addArrangedSubview(infoImage)
//        view.addSubview(infoStackView)
        view.addSubview(infoLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: idHistoryCell)
        
        setBackgroundImage()
    }
    
    func setBackgroundImage() {
        if data.isEmpty {
            infoLabel.isHidden = false
            NSLayoutConstraint.activate([
//                infoLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//                label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
                infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(UIScreen.main.bounds.height * 0.3))
            ])
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idHistoryCell, for: indexPath) as? HistoryTableViewCell else { fatalError("Мистер Анджело? Мисс Ячейка (History) передаёт вам привет")}
//        cell.monthDateLabel.text = "November, 2021"
        cell.monthDateLabel.text = data[indexPath.row] // MARK: (1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destination = MonthGoalsViewController(style: .grouped)
        destination.title = data[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
}

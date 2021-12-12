//
//  TrayViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

class AgendaViewController: UIViewController {
    let dayAndMonth = UILabel()
    let yearLabel = UILabel()
    let progressView = UIProgressView()
    // let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Agenda"
        
        getMonthInfo()  // view.addSubview(dateAndProgress)
        // view.addSubview(tableView)
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
        progressView.progress = Float(calendar.dateComponents([.day], from: date).day!) / Float(days)
        
        let dateView = UIStackView(arrangedSubviews: [dayAndMonth, yearLabel])
        dateView.axis = .horizontal
        dateView.setCustomSpacing(0, after: view)
//        dateView.spacing = 0
//        dateView.alignment = .leading
//        dateView.isLayoutMarginsRelativeArrangement = false
//        dateView.distribution = .fillProportionally
        let dateAndProgress = UIStackView(arrangedSubviews: [progressView, dateView])
        dateAndProgress.axis = .vertical
        dateAndProgress.spacing = 2
        view.addSubview(dateAndProgress)
        
        dateAndProgress.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateAndProgress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            dateAndProgress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dateAndProgress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}

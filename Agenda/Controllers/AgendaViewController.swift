//
//  TrayViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

class AgendaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Agenda"
        
        getMonthInfo()
    }
    
    func getMonthInfo() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let calendar = Calendar.current
        // Calculate start and end of the current year (or month with `.month`):
        let interval = calendar.dateInterval(of: .year, for: date)! //change year it will no of days in a year , change it to month it will give no of days in a current month
        // Compute difference in days:
        let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        
        
        let defaultString = dateFormatter.string(from: date)
        let arrayOfElements = defaultString.split(separator: ",")
        
        // MARK: Date labels
        let dayAndMonth = UILabel()
        dayAndMonth.attributedText = NSAttributedString(string: "\(arrayOfElements[0]),", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)])
        let year = UILabel()
        year.attributedText = NSAttributedString(string: String(arrayOfElements[1]), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)])
        let dateView = UIStackView(arrangedSubviews: [dayAndMonth, year])
        dateView.axis = .horizontal
        
        // MARK: ProgressView
        let progressView = UIProgressView()
        progressView.progress = calendar.dat / days
        // progressView.progress = 0.4
        progressView.progressTintColor = UIColor(red: 69/255, green: 208/255, blue: 100/255, alpha: 1)
        
        let dateAndProgress = UIStackView(arrangedSubviews: [progressView, dateView])
        dateAndProgress.axis = .vertical
        view.addSubview(dateAndProgress)
        dateAndProgress.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateAndProgress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            // titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            // titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
            dateAndProgress.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dateAndProgress.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}

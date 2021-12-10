//
//  TrayViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

class AgendaViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        getCurrentDate()
    }
    
    func getCurrentDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")

        // navigationItem.title = "Agenda"
        navigationItem.title = "\(dateFormatter.string(from: date))"
        
        // просто не очень решение
//        let titleStackView: UIStackView = {
//            let titleLabel = UILabel()
//            titleLabel.text = "Title"
//            let subtitleLabel = UILabel()
//            subtitleLabel.text = "Subtitle"
//            let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
//            stackView.axis = .horizontal
//            return stackView
//        }()
//        navigationItem.titleView = titleStackView
        
        // очень топорно вставляет, нет отступов крч
//        let titleLabel = UILabel()
//        titleLabel.text = "YourTitle"
//        titleLabel.font = UIFont.systemFont(ofSize: 30)
//        titleLabel.sizeToFit()
//        if let navigationBar = self.navigationController?.navigationBar {
//            navigationBar.addSubview(titleLabel)
//        }
    }
}

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
        
        let defaultString = dateFormatter.string(from: date)
        let arrayOfElements = defaultString.split(separator: ",")

        // navigationItem.title = "Agenda"
        navigationItem.title = "\(dateFormatter.string(from: date))"
        
        // MARK: моя попытка что-то сделать через label на основе ответов
        let dayAndMonth = UILabel()
        let year = UILabel()
        dayAndMonth.attributedText = NSAttributedString(string: String(arrayOfElements[0]), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 32)])
        year.attributedText = NSAttributedString(string: String(arrayOfElements[1]), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32)])

        let stackView = UIStackView(arrangedSubviews: [dayAndMonth, year])
        stackView.axis = .horizontal
        navigationItem.titleView = stackView

        // MARK: решение из stackoverflow
//        if let navigationBar = self.navigationController?.navigationBar {
//
//           let frame = CGRect(x: navigationBar.center.x-(navigationBar.center.x/3), y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
//           let myMutableString = NSMutableAttributedString(string: dateFormatter.string(from: date), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
//           myMutableString.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
//                                                  NSAttributedString.Key.foregroundColor: UIColor.black],
//                                                 range: NSMakeRange(0, 12))
//           let lbl = UILabel(frame: frame)
//           lbl.attributedText = myMutableString
//           navigationBar.addSubview(lbl)
//         }
        
        // navigationController?.navigationBar.prefersLargeTitles = true  // не работает
        
        // MARK: просто не очень решение
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
        
        // MARK: очень топорно вставляет, нет отступов крч
//        let titleLabel = UILabel()
//        titleLabel.text = "YourTitle"
//        titleLabel.font = UIFont.systemFont(ofSize: 30)
//        titleLabel.sizeToFit()
//        if let navigationBar = self.navigationController?.navigationBar {
//            navigationBar.addSubview(titleLabel)
//        }
    }
}

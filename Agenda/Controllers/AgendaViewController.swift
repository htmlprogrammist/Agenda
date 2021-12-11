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
    }
}

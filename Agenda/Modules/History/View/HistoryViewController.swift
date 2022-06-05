//
//  HistoryViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  

import UIKit

final class HistoryViewController: UITableViewController {
    
    private let output: HistoryViewOutput
    
    init(output: HistoryViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem
        title = Labels.History.title
        view.backgroundColor = .systemBackground
        
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        output.viewDidLoad()
    }
}

extension HistoryViewController: HistoryViewInput {
    func showAlert(title: String, message: String) {
//        alertForError(title: Labels.oopsError, message: Labels.History.fetchErrorDescription)
        alertForError(title: title, message: message)
    }
}

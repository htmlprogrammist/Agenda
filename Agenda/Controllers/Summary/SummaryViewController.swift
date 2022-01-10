//
//  ProfileViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

class SummaryViewController: UIViewController {
    
    let summary = Summary(minAimsForMonth: 2,
                          numberOfCompletedGoals: 3,
                          numberOfGoals: 5)
    let idSummaryCell = "idSummaryCell"
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Summary"
    }
}

extension SummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // summary has 4 things to display
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: idSummaryCell, for: indexPath) as? SummaryTableViewCell else { fatalError("SummaryCell fatalError") }
        let cell = tableView.dequeueReusableCell(withIdentifier: idSummaryCell, for: indexPath)
        return cell
    }
}

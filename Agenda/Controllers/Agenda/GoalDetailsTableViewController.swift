//
//  GoalDetailsTableViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 24.12.2021.
//

import UIKit

class GoalDetailsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: indexPath)
    }
}

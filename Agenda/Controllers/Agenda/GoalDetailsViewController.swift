//
//  GoalDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 16.12.2021.
//

import UIKit

class GoalDetailsViewController: UIViewController {
    
    var goal: Goal?
    
    override func viewDidLoad() {
        print(goal?.title, goal?.current, goal?.end)
        super.viewDidLoad()
    }
}

//
//  AddingGoalViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 17.12.2021.
//

import UIKit

class AddingGoalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addGoal))
        // надо узнать, как сделать так, чтобы на эту кнопку нельзя было нажимать, пока все поля не будут заполнены
        // соответственно, надо будет научиться подсвечивать каждое поле красным и писать ! required или типо того
    }
    
    @objc func addGoal() {
        
    }
}

//
//  AgendaViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 01.06.2022.
//  
//

import UIKit

// Отображение данных и обработка событий пользователя
final class AgendaViewController: UIViewController {
	
    private let output: AddGoalViewOutput

    init(output: AddGoalViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Agenda"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewGoal))
        navigationItem.leftBarButtonItem = editButtonItem
        
//        setupView()
//        setConstraints()
    }
}

extension AgendaViewController: AddGoalViewInput {
}

private extension AgendaViewController {
    
    @objc func addNewGoal() {
        
    }
}

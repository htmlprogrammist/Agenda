//
//  GoalDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  
//

import UIKit

final class GoalDetailsViewController: UIViewController {
	private let output: GoalDetailsViewOutput

    init(output: GoalDetailsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension GoalDetailsViewController: GoalDetailsViewInput {
}

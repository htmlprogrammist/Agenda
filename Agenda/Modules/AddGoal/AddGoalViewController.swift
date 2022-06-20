//
//  AddGoalViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  

import UIKit

final class AddGoalViewController: GoalViewController {
    
    private let output: AddGoalViewOutput
    
    public override var goalData: GoalData {
        didSet {
            checkBarButtonEnabled()
        }
    }
    
    private lazy var closeButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeThisVC))
        barButton.accessibilityIdentifier = "cancelButtonItem"
        return barButton
    }()
    private lazy var doneButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        barButton.isEnabled = false
        barButton.accessibilityIdentifier = "doneButtonItem"
        return barButton
    }()
    
    init(output: AddGoalViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = closeButtonItem
        navigationItem.rightBarButtonItem = doneButtonItem
        title = Labels.Agenda.newGoal
    }
}

extension AddGoalViewController: AddGoalViewInput {
}

// MARK: - Helper methods
private extension AddGoalViewController {
    @objc func doneButtonTapped() {
        output.doneButtonTapped(data: goalData)
    }
    
    @objc func closeThisVC() {
        output.closeThisModule()
    }
    
    func checkBarButtonEnabled() {
        if !goalData.title.isEmpty, !goalData.current.isEmpty, !goalData.aim.isEmpty {
            doneButtonItem.isEnabled = true
        } else {
            doneButtonItem.isEnabled = false
        }
    }
}

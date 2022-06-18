//
//  GoalDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 02.06.2022.
//  

import UIKit
import SPIndicator

final class GoalDetailsViewController: GoalViewController {
    
    private let output: GoalDetailsViewOutput
    
    public override var goalData: GoalData {
        didSet {
            output.checkBarButtonEnabled(goalData: goalData)
        }
    }
    
    private lazy var saveBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        barButton.isEnabled = false
        return barButton
    }()
    private let indicatorView: SPIndicatorView = {
        let indicatorView = SPIndicatorView(title: Labels.Agenda.saved, preset: .done)
        indicatorView.presentSide = .bottom
        indicatorView.iconView?.tintColor = .systemGreen
        return indicatorView
    }()
    
    init(output: GoalDetailsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        title = Labels.Agenda.details
        navigationItem.rightBarButtonItem = saveBarButton
        
        output.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        indicatorView.dismiss()
    }
}

// MARK: - ViewInput
extension GoalDetailsViewController: GoalDetailsViewInput {
    func setViewModel(goalData: GoalData) {
        self.goalData = goalData
        tableView.reloadData()
    }
    
    func updateBarButton(with flag: Bool) {
        saveBarButton.isEnabled = flag
    }
    
    func presentSuccess() {
        indicatorView.present(haptic: .success)
    }
}

// MARK: - UITableView
extension GoalDetailsViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalTableViewCell.identifier, for: indexPath) as? GoalTableViewCell
        else { return GoalTableViewCell() }
        cell.goal = goalData
        cell.delegate = self
        cell.configure(indexPath: indexPath)
        return cell
    }
}

// MARK: - Helper methods
private extension GoalDetailsViewController {
    @objc func saveButtonTapped() {
        view.endEditing(true)
        saveBarButton.isEnabled = false
        output.saveButtonTapped(data: goalData)
    }
}

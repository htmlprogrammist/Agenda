//
//  OnboardingViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.04.2022.
//  

import UIKit

final class OnboardingViewController: UIViewController {
    
    private let output: OnboardingViewOutput
    private let viewModels = [
        OnboardingViewModel(title: Labels.Onboarding.title1, description: Labels.Onboarding.description1, image: Icons.lightbulb),
        OnboardingViewModel(title: Labels.Onboarding.title2, description: Labels.Onboarding.description2, image: Icons.chartBarDoc),
        OnboardingViewModel(title: Labels.Onboarding.title3, description: Labels.Onboarding.description3, image: Icons.notesTextBadgePlus)
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OnboardingTableViewCell.self, forCellReuseIdentifier: OnboardingTableViewCell.identifier)
        tableView.register(OnboardingTableViewHeader.self, forHeaderFooterViewReuseIdentifier: OnboardingTableViewHeader.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "onboardingTableView"
        return tableView
    }()
    
    private let backgroundButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "onboardingButtonView"
        return view
    }()
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle(Labels.Onboarding.continueButtonLabel, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.zPosition = 1
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "onboardingButton"
        return button
    }()
    
    init(output: OnboardingViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
    }
}

extension OnboardingViewController: OnboardingViewInput {
}

// MARK: - Methods
private extension OnboardingViewController {
    
    @objc func continueButtonTapped() {
        output.continueButtonTapped()
    }
    
    func setupView() {
        isModalInPresentation = true
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        view.addSubview(backgroundButtonView)
        backgroundButtonView.addSubview(continueButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: backgroundButtonView.topAnchor),
            
            backgroundButtonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundButtonView.heightAnchor.constraint(equalToConstant: 84),
            
            continueButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}

// MARK: - UITableViewDataSource
extension OnboardingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingTableViewCell.identifier, for: indexPath) as? OnboardingTableViewCell
        else { return OnboardingTableViewCell() }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: OnboardingTableViewHeader.identifier) as? OnboardingTableViewHeader
        else {
            fatalError("Could not create header for the table view in History in section \(section)")
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

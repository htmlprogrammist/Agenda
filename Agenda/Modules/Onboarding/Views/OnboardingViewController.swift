//
//  OnboardingViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.04.2022.
//  

import UIKit

final class OnboardingViewController: UIViewController {
    
    private let output: OnboardingViewOutput
    
    private let titlesArray = [Labels.Onboarding.title1, Labels.Onboarding.title2, Labels.Onboarding.title3]
    private let descriptionsArray = [Labels.Onboarding.description1, Labels.Onboarding.description2, Labels.Onboarding.description3]
    private let imagePathsArray = ["lightbulb", "chart.bar.doc.horizontal", "note.text.badge.plus"]
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Labels.Onboarding.welcomeLabel
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var tableView: OnboardingTableView = {
        let tableView = OnboardingTableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        return tableView
    }()
    
    private let backgroundButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle(Labels.Onboarding.continueButtonLabel, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.zPosition = 1
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        button.backgroundColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
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
        
        isModalInPresentation = true
        
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
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(welcomeLabel)
        let labelText = welcomeLabel.text ?? ""
        let labelAttributedText = NSMutableAttributedString(string: labelText)
        let index = labelText.lastIndex(of: "A") ?? labelText.startIndex
        labelAttributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemRed, range: NSRange(location: (labelText.distance(from: labelText.startIndex, to: index)), length: 6))
        welcomeLabel.attributedText = labelAttributedText
        
        contentView.addSubview(tableView)
        
        view.addSubview(backgroundButtonView)
        backgroundButtonView.addSubview(continueButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: backgroundButtonView.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36),
            welcomeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
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
extension OnboardingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingTableViewCell.identifier, for: indexPath) as? OnboardingTableViewCell
        else { return OnboardingTableViewCell() }
        cell.backgroundColor = .clear
        cell.iconImageView.image = UIImage(named: imagePathsArray[indexPath.section])
        cell.titleLabel.text = titlesArray[indexPath.section]
        cell.descriptionLabel.text = descriptionsArray[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

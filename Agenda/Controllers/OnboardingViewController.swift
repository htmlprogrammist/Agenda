//
//  OnboardingViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.04.2022.
//

import UIKit
import SwiftUI

final class OnboardingViewController: UIViewController {
    
    private let mainTabBarController: UITabBarController
    
    private let titlesArray = [""]
    private let descriptionsArray = [
        "",
        "",
        ""]
    private let imagePathsArray = [""]
    private let colorsArray: [UIColor] = [.systemRed, .systemGreen, .systemBlue]
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 0
        tableView.backgroundColor = .clear
        tableView.register(OnboardingTableViewCell.self, forCellReuseIdentifier: OnboardingTableViewCell.identifier)
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.zPosition = 1
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 99/255, green: 210/255, blue: 255/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    init(_ mainTabBarController: UITabBarController) {
        self.mainTabBarController = mainTabBarController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupView()
        setContraints()
    }
}

// MARK: - Methods
private extension OnboardingViewController {
    
    func setupView() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//
//        contentView.addSubview(welcomeLabel)
//        contentView.addSubview(tableView)
        
//        if let locale = Locale.current.identifier
//        let labelText = NSMutableAttributedString(string: welcomeLabel.text ?? "")
//        labelText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 99/255, green: 210/255, blue: 255/255, alpha: 1.0), range: NSRange(location: 15, length: 6))
//        welcomeLabel.attributedText = labelText
//        welcomeLabel.numberOfLines = 0
    }
    
    func setContraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
    }
    
    @objc func continueButtonTapped() {
        let destination = mainTabBarController
        destination.modalPresentationStyle = .fullScreen
        UserDefaults.standard.hasOnboarded = true
        present(destination, animated: true, completion: nil)
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
        else {
            fatalError("Fatal error at creating OnboardingTableViewCell in `cellForRowAt` method")
        }
        cell.iconImageView.image = UIImage(systemName: imagePathsArray[indexPath.section])
        cell.iconImageView.tintColor = colorsArray[indexPath.section]
        cell.titleLabel.text = titlesArray[indexPath.section]
        cell.descriptionLabel.text = descriptionsArray[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

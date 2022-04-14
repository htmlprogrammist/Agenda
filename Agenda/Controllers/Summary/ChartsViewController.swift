//
//  ChartsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 12.04.2022.
//

import UIKit
import Charts

final class ChartsViewController: UIViewController {
    
    private let monthNames: [String]
    private let values: [Double]
    private let tintColor: UIColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        setupView()
        setConstraints()
    }
    
    init(monthNames: [String], values: [Double], name: String, tintColor: UIColor) {
        self.monthNames = monthNames
        self.values = values
        self.tintColor = tintColor
        
        super.init(nibName: nil, bundle: nil)
        title = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods
private extension ChartsViewController {
    
    func setupView() {
        
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

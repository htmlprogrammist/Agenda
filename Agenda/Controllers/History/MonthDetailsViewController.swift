//
//  MonthDetailsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.04.2022.
//

import UIKit

final class MonthDetailsViewController: UIViewController {
    
    private let month: Month
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    init(month: Month) {
        self.month = month
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  SummaryViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.06.2022.
//  
//

import UIKit

final class SummaryViewController: UIViewController {
    
    private let output: SummaryViewOutput
    
    init(output: SummaryViewOutput) {
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

extension SummaryViewController: SummaryViewInput {
}

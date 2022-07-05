//
//  ChartsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.07.2022.
//  
//

import UIKit
import Charts

final class ChartsViewController: UIViewController {
    
    private let output: ChartsViewOutput
    
    public var data: Summary!
    
    init(output: ChartsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewDidLoad(with: data.kind)
        setupView()
    }
}

extension ChartsViewController: ChartsViewInput {
    func showAlert(title: String, message: String) {
        alertForError(title: title, message: message)
    }
    
    func setDataEntries(data: [Double]) {
        print(data)
    }
}

private extension ChartsViewController {
    func setupView() {
        navigationItem.title = data.title
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
    }
}

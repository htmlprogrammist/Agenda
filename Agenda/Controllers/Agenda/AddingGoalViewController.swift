//
//  AddingGoalViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 17.12.2021.
//

import UIKit

class AddingGoalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Goal"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeThisVC))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        // надо узнать, как сделать так, чтобы на эту кнопку нельзя было нажимать, пока все поля не будут заполнены
        // соответственно, надо будет научиться подсвечивать каждое поле красным и писать ! required или типо того
        
        // можно сделать как в календаре (там пока title не заполнишь, кнопка недоступна для нажатия. Тут можно либо так же сделать (aim = 1, current = 0 по умолчанию), либо для всех полей сделать
    }
    
    @objc func closeThisVC() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func doneButtonTapped() {
        
        
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

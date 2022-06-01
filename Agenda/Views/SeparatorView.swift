//
//  SeparatorView.swift
//  Agenda
//
//  Created by Егор Бадмаев on 04.04.2022.
//

import UIKit

final class SeparatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewAndConstraints() {
        layer.zPosition = 1
        backgroundColor = UIColor(named: "SeparatorViewBgColor")
        translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

//
//  OnboardingTableView.swift
//  Agenda
//
//  Created by Егор Бадмаев on 12.04.2022.
//

import UIKit

final class OnboardingTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        sectionHeaderHeight = 0
        backgroundColor = .clear
        register(OnboardingTableViewCell.self, forCellReuseIdentifier: OnboardingTableViewCell.identifier)
        allowsSelection = false
        isScrollEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Since each row of the table view has its own height, which cannot be obtained,
    // it is necessary to somehow set the height for the table view, because without this it simply does not display.
    // This code allows to set table view contentSize correctly, so there's no need for using heightAnchor
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentSize.height)
    }
}

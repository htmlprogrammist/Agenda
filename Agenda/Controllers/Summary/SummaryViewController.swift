//
//  SummaryViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

final class SummaryViewController: UIViewController {
    
    private let coreDataManager: CoreDataManagerProtocol
    
    /// 1. Average number of completed goals
    /// 1. Completed goals
    /// 2. All goals
    /// 3. Uncompleted goals
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.size.width - 2 * 16
        layout.itemSize = CGSize(width: width, height: width * 0.3)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(SummaryCollectionViewCell.self, forCellWithReuseIdentifier: SummaryCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Summary"
        
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}

// MARK: - UICollectionView
extension SummaryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCollectionViewCell.identifier, for: indexPath) as? SummaryCollectionViewCell else { return SummaryCollectionViewCell() }
        return cell
    }
}

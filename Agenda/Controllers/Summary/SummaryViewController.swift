//
//  ProfileViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 10.12.2021.
//

import UIKit

class SummaryViewController: UIViewController {
    
    let summary = Summary(minAimsForMonth: 2,
                          numberOfCompletedGoals: 3,
                          numberOfGoals: 5)
    let idSummaryCell = "idSummaryCell"
    /*
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Summary"
    }
}

extension SummaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 // summary has 4 things to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: idSummaryCell, for: indexPath) as? SummaryCollectionViewCell else { fatalError("SummaryCell fatalError") }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idSummaryCell, for: indexPath)
        return cell
    }
}

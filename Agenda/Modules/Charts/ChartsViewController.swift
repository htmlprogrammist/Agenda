//
//  ChartsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.07.2022.
//  

import UIKit
import Charts

final class ChartsViewController: UIViewController {
    
    public var data: Summary!
    private let output: ChartsViewOutput
    
    private lazy var barChartView: BarChartView = {
        let barChartView = BarChartView()
        barChartView.noDataText = Labels.Summary.computingDataError
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        return barChartView
    }()
    
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
    
    func setDataEntries(data: [(String, Double)]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<data.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: data[i].1)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: self.data.measure)
        chartDataSet.colors = [self.data.tintColor]
        let chartData = BarChartData(dataSets: [chartDataSet])
        barChartView.data = chartData
    }
}

private extension ChartsViewController {
    func setupView() {
        navigationItem.title = data.title
        navigationItem.largeTitleDisplayMode = .never
        
        view.backgroundColor = .systemBackground
        view.addSubview(barChartView)
        
        NSLayoutConstraint.activate([
            barChartView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            barChartView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            barChartView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            barChartView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
}

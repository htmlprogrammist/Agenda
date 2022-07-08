//
//  ChartsViewController.swift
//  Agenda
//
//  Created by Егор Бадмаев on 03.07.2022.
//  

import UIKit
import Charts

final class ChartsViewController: UIViewController {
    
    private let output: ChartsViewOutput
    /// X-axis value formatter to display custom labels
    private let formatter = CustomLabelsXAxisValueFormatter()
    
    /// Model of Summary for which a request will be made and information will be displayed
    public var summary: Summary!
    
    private lazy var barChartView: BarChartView = {
        let barChartView = BarChartView()
        barChartView.noDataText = Labels.Charts.computingDataError
        barChartView.legend.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.pinchZoomEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        barChartView.accessibilityIdentifier = "barChartView"
        // Y - Axis Setup
        let leftAxis = barChartView.leftAxis
        leftAxis.axisMinimum = 0
        leftAxis.labelTextColor = .label
        leftAxis.axisLineColor = .label
        // X - Axis Setup
        let xAxis = barChartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.valueFormatter = formatter
        xAxis.labelPosition = .bottom
        xAxis.labelTextColor = .label
        xAxis.centerAxisLabelsEnabled = false
        xAxis.axisLineColor = .label
        xAxis.granularityEnabled = true
        xAxis.enabled = true
        return barChartView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "chartsDescriptionLabel"
        return label
    }()
    
    lazy var moreLessLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "chartsMoreLessLabel"
        return label
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
        
        output.viewDidLoad(with: summary)
        setupView()
    }
}

extension ChartsViewController: ChartsViewInput {
    /// Shows alert with preferred style `.alert`
    /// - Parameters:
    ///   - title: Title for the alert
    ///   - message: Message description
    func showAlert(title: String, message: String) {
        alertForError(title: title, message: message)
    }
    
    /// Sets data entries for the chart
    /// - Parameter data: The result of Interactor: array with months' names and values
    func setDataEntries(data: [(String, Double)]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<data.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: data[i].1)
            dataEntries.append(dataEntry)
        }
        formatter.labels = data.map { $0.0 }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: summary.measure)
        chartDataSet.colors = [summary.tintColor]
        let chartData = BarChartData(dataSets: [chartDataSet])
        barChartView.data = chartData
        
        barChartView.setVisibleXRangeMinimum(5)
        barChartView.setVisibleXRangeMaximum(7)
    }
}

// MARK: - Helper methods
private extension ChartsViewController {
    func setupView() {
        navigationItem.title = summary.title
        navigationItem.largeTitleDisplayMode = .never
        
        view.backgroundColor = .systemBackground
        view.addSubview(barChartView)
        view.addSubview(descriptionLabel)
        view.addSubview(moreLessLabel)
        
        descriptionLabel.text = summary.description
        moreLessLabel.text = summary.isLessBetter ? Labels.Charts.lessBetter : Labels.Charts.moreBetter
        
        NSLayoutConstraint.activate([
            barChartView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            barChartView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            barChartView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            barChartView.heightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/2),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: barChartView.bottomAnchor, constant: 16),
            
            moreLessLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            moreLessLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6)
        ])
    }
}

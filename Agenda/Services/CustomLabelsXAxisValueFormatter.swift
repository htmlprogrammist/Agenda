//
//  CustomLabelsXAxisValueFormatter.swift
//  Agenda
//
//  Created by Егор Бадмаев on 05.07.2022.
//

import Charts

class CustomLabelsXAxisValueFormatter: IAxisValueFormatter {
    
    var labels: [String] = []
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let count = self.labels.count
        
        guard let axis = axis, count > 0 else {
            return ""
        }
        
        let factor = axis.axisMaximum / Double(count)
        let index = Int((value / factor).rounded())
        
        if index >= 0 && index < count {
            return self.labels[index]
        }
        return ""
    }
}

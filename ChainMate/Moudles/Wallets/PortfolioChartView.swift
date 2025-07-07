//
//  PortfolioChartView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/7.
//

import SwiftUI
import DGCharts

struct PortfolioChartView: UIViewRepresentable {
    
    var dataPoints: [ChartPoint]
    
    func makeUIView(context: Context) -> DGCharts.LineChartView {
        let chartView = LineChartView()
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.legend.enabled = false
        chartView.setScaleEnabled(false)
        chartView.highlightPerTapEnabled = false
        return chartView
    }
    
    func updateUIView(_ uiView: DGCharts.LineChartView, context: Context) {
        let entries = dataPoints.enumerated().map { index, point in
            ChartDataEntry(x: Double(index), y: point.value)
        }
        
        let dataSet = LineChartDataSet(entries: entries, label: "USD估值")
        dataSet.mode = .cubicBezier
        dataSet.drawValuesEnabled = false
        dataSet.setColor(.systemBlue)
        dataSet.lineWidth = 2
        dataSet.circleRadius = 3
        dataSet.setCircleColor(.systemBlue)
        dataSet.drawCirclesEnabled = false
        dataSet.fillAlpha = 0.1
        dataSet.drawFilledEnabled = true
        dataSet.fillColor = .systemBlue
        
        let data = LineChartData(dataSet: dataSet)
        uiView.data = data
        
        // X轴自定义标签（日期）
        uiView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints.map { $0.date })
        uiView.xAxis.granularity = 1
    }
}

//#Preview {
//    LineChartWrapper(dataPoints: <#[ChatPoint]#>)
//}

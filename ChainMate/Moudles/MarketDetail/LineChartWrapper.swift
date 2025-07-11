//
//  LineChartWrapper.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/11.
//

import SwiftUI
import DGCharts

struct LineChartWrapper: UIViewRepresentable {
    var dataPoints: [ChartDataEntry]

    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.animate(xAxisDuration: 0.3)
        chart.setScaleEnabled(false)
        return chart
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        let dataSet = LineChartDataSet(entries: dataPoints, label: "价格")
        dataSet.colors = [.systemBlue]
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        dataSet.drawValuesEnabled = false
        dataSet.mode = .cubicBezier

        let data = LineChartData(dataSet: dataSet)
        uiView.data = data
    }
}

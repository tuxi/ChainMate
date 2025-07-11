//
//  LineChartWithMarker.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/11.
//

import SwiftUI
import DGCharts

struct LineChartWithMarker: UIViewRepresentable {
    var dataPoints: [PricePoint]

    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.setScaleEnabled(true)
        chart.animate(xAxisDuration: 0.4)

        // 添加 marker
        let marker = BalloonMarker(color: .lightGray,
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chart
        chart.marker = marker

        return chart
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        let entries = dataPoints.enumerated().map { index, point in
            ChartDataEntry(x: Double(index), y: point.price)
        }

        let dataSet = LineChartDataSet(entries: entries, label: "价格")
        dataSet.colors = [.systemBlue]
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        dataSet.drawValuesEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.highlightEnabled = true

        let data = LineChartData(dataSet: dataSet)
        uiView.data = data
    }
}

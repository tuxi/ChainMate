//
//  MarketDetailPriceChartView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/10.
//

import SwiftUI
import DGCharts

struct MarketDetailPriceChartView: View {
    let coinId: String
    @StateObject private var vm = PriceChartViewModel()
    
    private let periods: [(title: String, days: Int)] = [
            ("24H", 1), ("7D", 7), ("30D", 30), ("90D", 90), ("1Y", 365)
        ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
                    Text("价格走势")
                        .font(.headline)

                    HStack(spacing: 8) {
                        ForEach(periods, id: \.days) { period in
                            Button(action: {
                                vm.period = period.days
                                vm.fetchPriceHistory(for: coinId)
                            }) {
                                Text(period.title)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(vm.period == period.days ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                    .cornerRadius(6)
                            }
                        }
                    }

                    if vm.points.isEmpty {
                        ProgressView("加载中...")
                            .frame(height: 200)
                    } else {
                        LineChartWithMarker(dataPoints: vm.points)
                            .frame(height: 240)
                    }
                }
                .padding(.top, 8)
                .onAppear {
                    vm.fetchPriceHistory(for: coinId)
                }
    }
}

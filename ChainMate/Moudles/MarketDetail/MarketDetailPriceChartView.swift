//
//  MarketDetailPriceChartView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/10.
//

import SwiftUI

struct MarketDetailPriceChartView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("价格走势")
                .font(.headline)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 200)
                .overlay(Text("价格图表 (Placeholder)").foregroundColor(.gray))
            
            // 时间段按钮（占位）
            HStack {
                ForEach(["24H", "7D", "30D", "1Y"], id: \.self) { label in
                    Text(label)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(6)
                }
            }
        }
    }
}

#Preview {
    MarketDetailPriceChartView()
}

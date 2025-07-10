//
//  MarketDetailKeyStatsView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/10.
//

import SwiftUI

struct MarketDetailKeyStatsView: View {
    var body: some View {
           VStack(alignment: .leading) {
               Text("关键数据")
                   .font(.headline)

               LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                   StatCard(title: "市值", value: "$2.23T")
                   StatCard(title: "成交额", value: "$38B")
                   StatCard(title: "流通量", value: "19M BTC")
                   StatCard(title: "总量", value: "21M BTC")
               }
           }
       }
}

struct StatCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            Text(value)
                .font(.subheadline.bold())
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    MarketDetailKeyStatsView()
}

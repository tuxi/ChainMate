//
//  MarketDetailKeyStatsView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/10.
//

import SwiftUI

struct MarketDetailKeyStatsView: View {
    
    let info: CoinDetail
    
    var body: some View {
        
           VStack(alignment: .leading) {
               Text("关键数据")
                   .font(.headline)

               LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                   StatCard(title: "市值", value: formatCurrency(info.market_data?.marketCap.usd))
                   StatCard(title: "成交额", value: formatCurrency(info.market_data?.totalVolume.usd))
                   StatCard(title: "流通量", value: formatSupply(info.market_data?.circulatingSupply, symbol: info.symbol ?? ""))
                       StatCard(title: "总量", value: formatSupply(info.market_data?.totalSupply, symbol: info.symbol ?? ""))
               }
               
               Divider()
               
               // 其他信息
               if let rank = info.market_data?.marketCapRank {
                   InfoRow(label: "市值排名", value: "#\(rank)")
               }
               if let genesis = info.genesis_date {
                   InfoRow(label: "创世时间", value: genesis)
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

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
        .font(.subheadline)
    }
}
func formatCurrency(_ value: Double?) -> String {
    guard let v = value else { return "--" }
    if v >= 1_000_000_000_000 {
        return String(format: "$%.2fT", v / 1_000_000_000_000)
    } else if v >= 1_000_000_000 {
        return String(format: "$%.2fB", v / 1_000_000_000)
    } else if v >= 1_000_000 {
        return String(format: "$%.2fM", v / 1_000_000)
    } else {
        return String(format: "$%.2f", v)
    }
}

func formatSupply(_ value: Double?, symbol: String) -> String {
    guard let v = value else { return "--" }
    if v >= 1_000_000 {
        return String(format: "%.0fM %@", v / 1_000_000, symbol.uppercased())
    } else {
        return String(format: "%.0f %@", v, symbol.uppercased())
    }
}

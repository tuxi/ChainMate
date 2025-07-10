//
//  MarketDetailAboutView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/10.
//

import SwiftUI

struct MarketDetailAboutView: View {
    @Binding var showFull: Bool

    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("关于")
                .font(.headline)

            Text(
                "Bitcoin 是一种去中心化数字货币，由中本聪于 2009 年发布。它允许点对点交易，完全不依赖中介。目前是全球最大的加密资产，具有广泛的市场接受度。"
            )
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(showFull ? nil : 3)

            Button(action: {
                showFull.toggle()
            }) {
                Text(showFull ? "收起" : "展开")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
    }
}

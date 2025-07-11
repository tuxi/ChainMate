//
//  MarketDetailAboutView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/10.
//

import SwiftUI

struct MarketDetailAboutView: View {
    let info: CoinDetail
    @Binding var showFull: Bool
    

    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("关于")
                .font(.headline)

            Text((info.description?.en ?? "")
                .replacingOccurrences(of: "\r\n", with: "\n")
                .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
            )
            .font(.body)
            .foregroundStyle(.primary)
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

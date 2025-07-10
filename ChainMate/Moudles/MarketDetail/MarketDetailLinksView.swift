//
//  MarketDetailLinksView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/10.
//

import SwiftUI

struct MarketDetailLinksView: View {
    var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text("相关链接")
                    .font(.headline)

                LinkRow(title: "官网", url: "https://bitcoin.org")
                LinkRow(title: "区块浏览器", url: "https://blockchair.com/bitcoin")
                LinkRow(title: "GitHub", url: "https://github.com/bitcoin")
            }
        }
}

struct LinkRow: View {
    let title: String
    let url: String

    var body: some View {
        HStack {
            Image(systemName: "link")
            Link(title, destination: URL(string: url)!)
            Spacer()
        }
    }
}

#Preview {
    MarketDetailLinksView()
}

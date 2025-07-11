//
//  MarketDetailView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/9.
//

import SwiftUI

/*
 MarketDetailView
 ├─ HeaderView         // 币种图标 + 名称 + 当前价格 + 涨跌幅
 ├─ PriceChartView     // 假图表 + 周期切换按钮
 ├─ KeyStatsView       // 市值、流通量等
 ├─ AboutView          // 项目简介（可折叠）
 ├─ LinksView          // 外部链接（官网 / 浏览器等）

 */

struct MarketDetailView: View {
    
    let coin: MarketCoin
    @StateObject var vm = MarketDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let detail = vm.detail {
                    // 头部信息
                    MarketDetailHeaderView(coin: coin)
                    
                    // 价格图表📈
                    MarketDetailPriceChartView(coinId: coin.id ?? "")
                    
                    // 核心数据
                    MarketDetailKeyStatsView()
                    
                    // 简介
                    MarketDetailAboutView(showFull: $vm.showFullDescription)
                    
                    // 外链
                    MarketDetailLinksView()
                } else if vm.isLoading {
                    ProgressView("加载中...")
                } else if let errorMessage = vm.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
            }
            .padding()
        }
        .navigationTitle(coin.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.fetchDetail(for: coin.id ?? "")
        }
    }
}

#Preview {
    MarketDetailView(coin: CoinPlaceholder.coin)
}

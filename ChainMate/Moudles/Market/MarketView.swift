//
//  MarketView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/7.
//

import SwiftUI

struct MarketView: View {
    
    @StateObject private var vm = MarketViewModel()
    @StateObject private var routerPath = RouterPath()
    
    var body: some View {
        NavigationStack(path: $routerPath.path) {
            List(vm.coins) { coin in
                NavigationLink(value: RouterPath.Destination.marketDetail(coin)) {
                    MarketRow(coin: coin)
                }
            }
            .withAppRouter()
            .refreshable {
                vm.fetchMarketData()
            }
            .navigationTitle("市场行情")
        }
        .onAppear {
            vm.fetchMarketData()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // App进入前台刷新
            vm.fetchMarketData()
        }
    }
}

#Preview {
    MarketView()
}

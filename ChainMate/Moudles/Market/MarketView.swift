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
                HStack {
                    
                    TokenIconView(url: coin.image ?? "", size: 32)
                    
                    VStack(alignment: .leading) {
                        Text(coin.name ?? "")
                            .font(.headline)
                        Text(coin.symbol?.uppercased() ?? "")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("$\((coin.current_price ?? 0), specifier: "%.5f")")
                            .font(.subheadline)
                        Text("\((coin.price_change_percentage_24h ?? 0), specifier: "%.2f")%")
                            .font(.caption)
                            .foregroundColor((coin.price_change_percentage_24h ?? 0) >= 0 ? .green : .red)
                    }
                }
                .padding(.vertical, 6)
            }
            .navigationTitle("市场行情")
        }
        .onAppear {
            vm.fetchMarketData()
        }
    }
}

#Preview {
    MarketView()
}

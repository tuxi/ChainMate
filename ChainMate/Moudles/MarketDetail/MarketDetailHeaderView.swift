//
//  MarketDetailHeaderView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/10.
//

import SwiftUI

struct MarketDetailHeaderView: View {
    
    let coin: MarketCoin
    
    var body: some View {
        HStack(spacing: 12) {
            TokenIconView(url: coin.image ?? "", size: 48)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name ?? "")
                    .font(.title2.bold())
                
                Text((coin.symbol ?? "").uppercased())
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\((coin.current_price ?? 0), specifier: "%.2f")")
                    .font(.headline)
                
                Text("\((coin.price_change_percentage_24h ?? 0), specifier: "%.2f")%")
                    .font(.subheadline)
                    .foregroundColor(
                        (coin.price_change_percentage_24h ?? 0) >= 0 ? .green : .red
                    )
            }
        }
    }
}

#Preview {
    MarketDetailHeaderView(coin: CoinPlaceholder.coin)
}

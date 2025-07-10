//
//  MarketRow.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/10.
//

import SwiftUI

struct MarketRow: View {
    
    @State var coin: MarketCoin?
    
    var body: some View {
        HStack {
            
            TokenIconView(url: coin?.image ?? "", size: 32)
            
            VStack(alignment: .leading) {
                Text(coin?.name ?? "")
                    .font(.headline)
                Text(coin?.symbol?.uppercased() ?? "")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("$\((coin?.current_price ?? 0), specifier: "%.5f")")
                    .font(.subheadline)
                Text("\((coin?.price_change_percentage_24h ?? 0), specifier: "%.2f")%")
                    .font(.caption)
                    .foregroundColor((coin?.price_change_percentage_24h ?? 0) >= 0 ? .green : .red)
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    MarketRow()
}

//
//  WalletSummaryView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/7.
//

import SwiftUI

// 总资产估值实图
struct WalletSummaryView: View {
    let totalValueUSD: Double
    let tokenList: [TokenBalance]
    
    @State var showTokens: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Text("$\(totalValueUSD, specifier: "%.2f")")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primary)
                    
                if showTokens == false {
                    Button {
                        showTokens = true
                    } label: {
                        Text("查看代币")
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                        Spacer()
                    }
                }
            }
            
            if showTokens == true {
                ForEach(tokenList) { token in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(token.contract_display_name ?? token.contract_ticker_symbol ?? "未知")
                                .font(.headline)
                            Text(token.displayTokenBalance)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("$\(token.quote ?? 0, specifier: "%.2f")")
                            .bold()
                    }
                }
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
    
    func formatTokenAmount(_ token: TokenBalance) -> String {
        guard let rawBalance = token.balance,
              let decimals = token.contract_decimals,
              let balance = Double(rawBalance),
              decimals >= 0 else {
            return "-"
        }
        
        let realBalance = balance / pow(10.0, Double(decimals))
        return "\(realBalance.cleanValue) \(token.contract_ticker_symbol ?? "")"
    }
}

//
//  WalletDetailView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/26.
//

import SwiftUI
import AlertToast

struct WalletDetailView: View {
    
    let wallet: Wallet
    @State var isShowPasteSuss = false
    
    @StateObject private var model = WalletDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 钱包名称和地址
                VStack(alignment: .leading) {
                    Text(wallet.name)
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        Text(wallet.address)
                            .font(.subheadline)
                            .foregroundStyle(Color(.gray))
                            
                        Button(action: {
                            UIPasteboard.general.string = wallet.address
                            isShowPasteSuss = true
                        }) {
                            Image(systemName: "doc.on.doc")
                        }
                    }
                    
                    Divider()
                    
                    Text("代币资产")
                        .font(.headline)
                    
                
                    
                    ForEach(model.balances) { token in
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
                    
                    Divider()
                    Text("最近交易")
                        .font(.headline)
                    
                    ForEach(model.transactions.prefix(10)) { transaction in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(transaction.block_signed_at?.formatISO8601() ?? "")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            
                            HStack {
                                Image(systemName: transaction.successful ? "checkmark.circle" : "xmark.circle")
                                    .foregroundStyle(transaction.successful ? Color.green : Color.red)
                                Text(transaction.from_address == wallet.address.lowercased() ? "→ 发送交易" : "← 接收交易")
                                                .font(.subheadline)
                                
                                Spacer()
                                Text("\(formatTokenBalance(balance: transaction.value ?? "", decimals: 18)) ETH")
                                                .font(.subheadline)
                                                .bold()
                                
                            }
                        }
                        .padding(.vertical, 4)
                    }
                   
                }
                
                Divider()
            }
            .padding()
        }
        .toast(isPresenting: $isShowPasteSuss, alert: {
            AlertToast(displayMode: .alert, type: .regular, title: "已复制")
        })
        .onAppear {
            model.getBalances(address: wallet.address)
            model.getTransactions(address: wallet.address)
        
        }
        .navigationTitle("钱包详情")
    }
    
    func shortAddress(_ address: String) -> String {
            let start = address.prefix(6)
            let end = address.suffix(4)
            return "\(start)...\(end)"
        }
}

#Preview {
    WalletDetailView(wallet: .init(name: "Joy", address: "0xadsfsdf3..."))
}

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
    
    @StateObject private var model = WalletDetailViewModel()
    
    @State var isShowPasteSuss = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    // 钱包名称和地址
                    WalletHeaderView(wallet: wallet, isShowPasteSuss: $isShowPasteSuss)
                    
                    Divider()
                    Text("总资产估值（USD）")
                        .font(.headline)
                    // 当前前总资产估值，以及资产明细
                    WalletSummaryView(totalValueUSD: model.totalBalance ?? 0, tokenList: model.balancesModel?.items ?? [])
                    
                    Divider()
                    Text("代币资产（USD）")
                        .font(.headline)
                    
                    // 📈 资产走势图表（30天）
                    PortfolioChartView(dataPoints: model.historyPoints ?? [])
                        .frame(height: 200)
                    
                    Divider()
                    Text("最近交易")
                        .font(.headline)
                    
                    if let transactionsModel = model.transactionsModel, let chainId = ChainId(rawValue: transactionsModel.chain_id) {
                        recentTrasactionsView(model: transactionsModel, chain: chainId)
                    }
                    
                    Divider()
                    
                }
                
            }
            .padding()
        }
        .toast(isPresenting: $isShowPasteSuss, alert: {
            AlertToast(displayMode: .alert, type: .regular, title: "已复制")
        })
        .onAppear {
            model.getBalances(address: wallet.address)
            model.getTransactions(address: wallet.address)
            model.getPortfolioHistory(address: wallet.address)
            
        }
        .navigationTitle("钱包详情")
    }
    
    
    // 最近交易列表
    @ViewBuilder
    func recentTrasactionsView(model: ChainData<TokenTransactionItem>, chain: ChainId) -> some View {
        ForEach(model.items.prefix(10)) { transaction in
            
            TransactionRowView(model: transaction, walletAddress: wallet.address, chainId: model.chain_id)
            
        }
        
        Divider()
        
        // 查看所有转移记录
        NavigationLink(value: RouterPath.Destination.transactionList(walletAddress: wallet.address, chainId: chain.rawValue)) {
            Text("查看全部记录")
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity)
                .font(.subheadline)
                .padding(.top, 6)
        }
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

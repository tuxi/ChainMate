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
                VStack(alignment: .leading) {
                    // 钱包名称和地址
                    headerView()
                    
                    Divider()
                    
                    Text("代币资产")
                        .font(.headline)
                    
                    if let balancesModel = model.balancesModel {
                        allAssetsView(model: balancesModel)
                    }
                    
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
        
        }
        .navigationTitle("钱包详情")
    }
    
    @ViewBuilder
    func headerView() -> some View {
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
        
    }
    
    // 所有资产
    @ViewBuilder
    func allAssetsView(model: ChainData<TokenBalance>) -> some View {
        ForEach(model.items) { token in
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

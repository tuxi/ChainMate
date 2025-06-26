//
//  WalletListView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/26.
//

import SwiftUI

struct WalletListView: View {
    // 测试数据
    @State private var wallets = [
        Wallet(name: "Main Wallet", address: "0xAbc123..."),
        Wallet(name: "DeFi Wallet", address: "0xDef456..."),
    ]
    
    var body: some View {
        NavigationView {
            List(wallets) { wallet in
                NavigationLink(destination: WalletDetailView(wallet: wallet)) {
                    VStack(alignment: .leading) {
                        Text(wallet.name)
                            .font(.headline)
                        Text(wallet.address)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Wallets")
            .toolbar {
                Button(action: {
                    // 这里可以添加添加钱包逻辑
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    WalletListView()
}

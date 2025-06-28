//
//  WalletListView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/26.
//

import SwiftUI

struct WalletListView: View {
    
    @StateObject var model = WalletListViewModel()
    
    @StateObject private var routerPath = RouterPath()
    @State private var showingAddWalletSheet = false
    
    var body: some View {
        NavigationStack(path: $routerPath.path) {
            List(model.wallets) { wallet in
                NavigationLink(value: RouterPath.Destination.walletDetail(wallet)) {
                    WalletRowView(wallet: wallet)
                }
            }
            .withAppRouter()
            .sheet(isPresented: $showingAddWalletSheet, content: {
                AddWalletView(wallets: $model.wallets)
            })
            .navigationTitle("Wallets")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // 这里可以添加添加钱包逻辑
                        showingAddWalletSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    WalletListView()
}

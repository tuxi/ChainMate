//
//  AppRouter.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/26.
//

import SwiftUI

extension View {
    func withAppRouter() -> some View {
        navigationDestination(for: RouterPath.Destination.self) {
            switch $0 {
            case .walletDetail(let wallet):
                WalletDetailView(wallet: wallet)
            case .transactionList(let walletAddress, let chainId):
                TransactionListView(walletAddress: walletAddress, chainId: chainId)
            case .marketDetail(let coin):
                MarketDetailView(coin: coin)
            }
        }
    }
    
//    func withSheetDestinations(sheetDestinations: Binding<SheetDestination?>, onDismiss: (() -> ())? = nil) -> some View {
//        sheet(item: sheetDestinations, onDismiss: onDismiss) { dest in
//            switch dest {
//            case .addWallet:
//                AddWalletView(wallets: <#T##Binding<[Wallet]>#>)
//            }
//        }
//    }
}

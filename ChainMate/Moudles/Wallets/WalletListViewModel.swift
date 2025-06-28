//
//  WalletListViewModel.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/27.
//

import Foundation

class WalletListViewModel: ObservableObject {
    
    @Published var wallets: [Wallet] = [
        Wallet(name: "Main Wallet", address: "0xAbc123..."),
        Wallet(name: "DeFi Wallet", address: "0xDef456..."),
    ]
}

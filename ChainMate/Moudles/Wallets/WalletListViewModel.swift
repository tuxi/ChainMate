//
//  WalletListViewModel.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/27.
//

import Foundation

class WalletListViewModel: ObservableObject {
    
    @Published var wallets: [Wallet] = [
        Wallet(name: "Main Wallet", address: "0xdadB0d80178819F2319190D340ce9A924f783711"),
        Wallet(name: "DeFi Wallet", address: "0xe7a03a274e4dDE67c63c3859FAc5BdaCFC4fae0f"),
    ]
}

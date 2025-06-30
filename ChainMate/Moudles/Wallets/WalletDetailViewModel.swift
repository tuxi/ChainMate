//
//  WalletDetailViewModel.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/29.
//

import Foundation

class WalletDetailViewModel: ObservableObject {
    @Published var tokens: [TokenBalance] = []
    
    func load(address: String) {
        BlockchainAPI.shared.fetchTokenBalances(address: address) { [weak self] balances in
            self?.tokens = balances
        }
    }
}

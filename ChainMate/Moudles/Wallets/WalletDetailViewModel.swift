//
//  WalletDetailViewModel.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/29.
//

import Foundation

class WalletDetailViewModel: ObservableObject {
    @Published var tokens: [TokenBalance] = []
    
    
    @MainActor
    func getBalances(address: String) {
        Task { @MainActor in
            do {
                let items = try await BlockchainAPI.shared.fetchTokenBalances(address: address)
                self.tokens = items
            } catch {
                print(error)
            }
        }
    }
}

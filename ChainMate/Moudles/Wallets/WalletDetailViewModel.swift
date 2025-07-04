//
//  WalletDetailViewModel.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/29.
//

import Foundation

class WalletDetailViewModel: ObservableObject {
    @Published var balances: [TokenBalance] = []
    @Published var transactions: [TokenTransactionItem] = []
    
    @MainActor
    func getBalances(address: String) {
        Task { @MainActor in
            do {
                let items = try await BlockchainAPI.shared.fetchTokenBalances(address: address)
                self.balances = items
            } catch {
                print(error)
            }
        }
    }
    
    func getTransactions(address: String) {
        Task { @MainActor in
            do {
                let items = try await BlockchainAPI.shared.fetchTransactions(address: address)
                 self.transactions = items
            } catch {
                print(error)
            }
        }
    }
}

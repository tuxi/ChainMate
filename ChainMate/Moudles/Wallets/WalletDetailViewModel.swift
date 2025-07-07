//
//  WalletDetailViewModel.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/29.
//

import Foundation

class WalletDetailViewModel: ObservableObject {
    @Published var balancesModel: ChainData<TokenBalance>?
    @Published var transactionsModel: ChainData<TokenTransactionItem>?
    @Published var historyPoints: [ChartPoint]?
    
    @Published var totalBalance: Double?
    
    @MainActor
    func getBalances(address: String) {
        Task { @MainActor in
            do {
                let model = try await BlockchainAPI.shared.fetchTokenBalances(address: address)
                self.balancesModel = model
                // 计算总资产
                self.totalBalance = balancesModel?.items
                    .compactMap { $0.quote }
                    .reduce(0, +)
            } catch {
                print(error)
            }
        }
    }
    
    func getTransactions(address: String) {
        Task { @MainActor in
            do {
                let model = try await BlockchainAPI.shared.fetchTransactions(address: address)
                 self.transactionsModel = model
            } catch {
                print(error)
            }
        }
    }
    
    func getPortfolioHistory(address: String) {
        Task { @MainActor in
            do {
                let model = try await BlockchainAPI.shared.fetchPortfolioHistory(address: address, days: 30)
                self.historyPoints = ChartPoint.aggregatePortfolioHistory(items: model.items)
            } catch {
                print(error)
            }
        }
    }
    
}

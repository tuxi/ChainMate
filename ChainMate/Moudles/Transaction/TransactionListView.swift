//
//  TransactionListView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/6.
//

import SwiftUI

struct TransactionListView: View {
    
    let walletAddress: String
    let chainId: Int
    
    @State private var transactions: [TokenTransactionItem] = []
    @State private var currentPage = 0
    @State private var isLoading = false
    @State private var hasMore = true
    
    
    var body: some View {
        List {
            ForEach(transactions) { tx in
                TransactionRowView(model: tx, walletAddress: walletAddress, chainId: chainId)
            }
            
            if hasMore {
                HStack {
                    Spacer()
                    if isLoading {
                        ProgressView()
                    } else {
                        Button("加载更多") {
                            loadNextPage()
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("交易记录")
        .onAppear {
            if transactions.isEmpty {
                loadNextPage()
            }
        }
    }
    
    func loadNextPage() {
        guard !isLoading else { return }
        isLoading = true
        
        let pageSize = 20
        let nextPage = currentPage + 1
        
        Task { @MainActor in
            do {
                let data = try await BlockchainAPI.shared.fetchTransactions(address: walletAddress, pageNumber: nextPage, pageSize: pageSize)
                isLoading = false
                currentPage = nextPage
                
                if data.items.isEmpty {
                    hasMore = false
                } else {
                    transactions.append(contentsOf: data.items)
                }
            } catch {
                
            }
        }
    }
}
    //
    //#Preview {
    //    TransactionListView()
    //}

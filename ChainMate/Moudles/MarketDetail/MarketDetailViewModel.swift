//
//  MarketDetailViewModel.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/9.
//

import Foundation

class MarketDetailViewModel: ObservableObject {
    
    let coin: MarketCoin
    
    @Published var showFullDescription = false
    
    init(coin: MarketCoin, showFullDescription: Bool = false) {
        self.coin = coin
        self.showFullDescription = showFullDescription
    }
}

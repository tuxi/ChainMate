//
//  MarketViewModel.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/7.
//

import Foundation
import Alamofire

class MarketViewModel: ObservableObject {
    
    @Published var coins: [MarketCoin] = []
    
    // Top市场行情
    func fetchMarketData() {
        // https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1
        let urlStr = "https://api.coingecko.com/api/v3/coins/markets"
        
        let vs_currency = "usd"
        let order = "market_cap_desc"
        let per_page = 50
        let page = 1
        
        
        let request = AF.request(urlStr, parameters: ["vs_currency": vs_currency, "order": order, "per_page": per_page, "page": page])
        
        request.responseDecodable(of: [MarketCoin].self) { response in
            switch response.result {
            case .success(let coins):
                self.coins = coins
            case .failure(let error):
                print(error)
            }
        }

    }
}

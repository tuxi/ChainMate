//
//  MarketDetailViewModel.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/9.
//

import Foundation
import Alamofire

@MainActor
class MarketDetailViewModel: ObservableObject {
    
    @Published var detail: CoinDetail?
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var showFullDescription = false
    
    func fetchDetail(for coinId: String) {
        if isLoading {
            return
        }
        isLoading = true
        errorMessage = nil
        
        /*
         GET 
         https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false

         */
        
        
        let urlStr = "https://api.coingecko.com/api/v3/coins/\(coinId)?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false"
        let parameters = ["localization": false,
                          "tickers": false,
                          "market_data": true,
                          "community_data": false,
                          "developer_data" :false]
        
        let request = AF.request(urlStr, parameters: parameters)
        
        request.responseDecodable(of: CoinDetail.self) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let detail):
                    self.detail = detail
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = "加载失败：\(error.localizedDescription)"
                }
                
                self.isLoading = false
            }
        }
    }
}

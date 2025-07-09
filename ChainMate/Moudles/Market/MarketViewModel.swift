//
//  MarketViewModel.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/7.
//

import Foundation
import Alamofire

@MainActor
class MarketViewModel: ObservableObject {
    
    @Published var coins: [MarketCoin] = []
    private var timer: Timer?
    private var isLoading = false
    private var currentRequest: DataRequest?
    
    init() {
        fetchMarketData()
        startAutoRefresh()
    }
    
    deinit {
        timer?.invalidate()
        currentRequest?.cancel()
    }
    
    // 自动刷新机制 30秒刷新一次最新市场行情
    func startAutoRefresh() {
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { [weak self] timer in
            Task { @MainActor [weak self] in
                self?.fetchMarketData()
            }
        })
    }
    
    // Top市场行情
    func fetchMarketData() {
        
        // 取消之前的请求,防止重复请求
        guard !isLoading else {
            return
        }
        isLoading = true
        
        // https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1
        let urlStr = "https://api.coingecko.com/api/v3/coins/markets"
        
        let vs_currency = "usd"
        let order = "market_cap_desc"
        let per_page = 50
        let page = 1
        
        // 如果有正在进行请求，先取消掉
        currentRequest?.cancel()
        
        currentRequest = AF
            .request(urlStr,
                     parameters: ["vs_currency": vs_currency, "order": order, "per_page": per_page, "page": page])
            .validate()
            .responseDecodable(of: [MarketCoin].self) { [weak self] response in
                DispatchQueue.main.async { [unowned self] in
                    switch response.result {
                    case .success(let coins):
                        self?.coins = coins
                    case .failure(let error):
                        if error.isExplicitlyCancelledError == true {
                            print("请求已取消")
                        } else {
                            print("行情接口请求失败：" + error.localizedDescription)
                        }
                    }
                    
                    self?.isLoading = false
                }
            }
        
    }
}

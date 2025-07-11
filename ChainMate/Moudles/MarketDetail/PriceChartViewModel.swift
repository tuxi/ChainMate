//
//  PriceChartViewModel.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/11.
//

import Foundation
import DGCharts

struct PricePoint {
    let timestamp: TimeInterval
    let price: Double
}

class PriceChartViewModel: ObservableObject {
    @Published var points: [PricePoint] = []
    
    @Published var period: Int = 7

    // 图表的内容来源，CoinGecko 的历史价格接口
    func fetchPriceHistory(for coinId: String) {
        let urlStr = "https://api.coingecko.com/api/v3/coins/\(coinId)/market_chart?vs_currency=usd&days=\(period)"
        guard let url = URL(string: urlStr) else { return }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode(PriceHistoryResponse.self, from: data)
                let pricePoints = decoded.prices.map { array in
                    PricePoint(timestamp: array[0], price: array[1])
                }
                DispatchQueue.main.async {
                    self.points = pricePoints
                }
            } catch {
                print("解析失败: \(error)")
            }
        }
    }

    struct PriceHistoryResponse: Decodable {
        let prices: [[Double]]
    }
}


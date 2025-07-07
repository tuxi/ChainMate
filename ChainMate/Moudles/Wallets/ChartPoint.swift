//
//  ChartPoint.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/7.
//

import Foundation

struct ChartPoint: Identifiable {
    let id = UUID()
    let date: String
    let value: Double
    
    
    static func aggregatePortfolioHistory(items: [ChartPointItem]) -> [ChartPoint] {
        // 时间戳 => quote 总和
        var dateToQuoteMap: [String: Double] = [:]

        for item in items {
            for holding in item.holdings {
                guard let date = holding.timestamp,
                      let quote = holding.close?.quote else { continue }

                dateToQuoteMap[date, default: 0] += Double(quote)
            }
        }

        let sorted = dateToQuoteMap
            .map { ChartPoint(date: $0.key.prefix(10).description, value: $0.value) }
            .sorted { $0.date < $1.date }

        return sorted
    }

}

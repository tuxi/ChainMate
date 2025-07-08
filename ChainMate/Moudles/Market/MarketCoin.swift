//
//  MarketCoin.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/7.
//

import Foundation

struct MarketCoin: Identifiable, Codable {
    var ath: Float?
    var ath_change_percentage: Float?
    var ath_date: String?
    var atl: Float?
    var atl_change_percentage: Float?
    var atl_date: String?
    var circulating_supply: Float?
    var current_price: Double?
    var fully_diluted_valuation: Int?
    var high_24h: Float?
    var id: String?
    var image: String?
    var last_updated: String?
    var low_24h: Float?
    var market_cap: Int?
    var market_cap_change_24h: Float?
    var market_cap_change_percentage_24h: Float?
    var market_cap_rank: Int?
    var max_supply: Double?
    var name: String?
    var price_change_24h: Double?
    var price_change_percentage_24h: Float?
    var roi: Roi?
    var symbol: String?
    var total_supply: Float?
    var total_volume: Int?

    struct Roi: Codable {
        var times: Double?
        var currency: String?
        var percentage: Double?
        var last_updated: String?
    }
    
}

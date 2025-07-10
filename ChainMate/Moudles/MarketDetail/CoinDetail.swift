//
//  CoinDetail.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/10.
//

import Foundation

struct CoinDetail: Decodable {
    let id: String
    var symbol: String?
    var name: String?
    var description: Description?
    var image: CoinImage?
    var market_data: MarketData?
    var links: CoinLinks?
    var hashing_algorithm: String?

    struct Description: Decodable {
        var en: String?
    }

    struct CoinImage: Decodable {
        var large: String?
        var thumb: String?
        var small: String?
    }

    struct MarketData: Decodable {
        let currentPrice: [String: Double]
        let marketCap: [String: Double]
        let totalVolume: [String: Double]
        let circulatingSupply: Double?
        let totalSupply: Double?
        let marketCapRank: Int?
        let ath: [String: Double]?

        enum CodingKeys: String, CodingKey {
            case currentPrice = "current_price"
            case marketCap = "market_cap"
            case totalVolume = "total_volume"
            case circulatingSupply = "circulating_supply"
            case totalSupply = "total_supply"
            case marketCapRank = "market_cap_rank"
            case ath
        }
    }

    struct CoinLinks: Decodable {
        var homepage: [String]?
        // 白皮书
        var whitepaper: String?
        var blockchainSite: [String]?
        var reposUrl: ReposUrl?

        enum CodingKeys: String, CodingKey {
            case homepage
            case whitepaper
            case blockchainSite = "blockchain_site"
            case reposUrl = "repos_url"
        }

        struct ReposUrl: Decodable {
            var github: [String]?
            var bitbucket: [String]?
        }
    }
}

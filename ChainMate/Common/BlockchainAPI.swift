//
//  BlockchainAPI.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/29.
//

import Foundation
import Alamofire

class BlockchainAPI {
    static let shared = BlockchainAPI()
    private var apiKey: String = ""
    
    // 是不是无效的apiKey
    var isInvalidApiKey: Bool {
        guard let apiKeyPath = Bundle.main.path(forResource: "api", ofType: "key") else {
            return true
        }
        do {
            var text = try String(contentsOf: URL(filePath: apiKeyPath), encoding: .utf8)
            if text.hasSuffix("\n") {
                text.removeLast()
            }
            self.apiKey = text
            return false
        } catch {
            print("Load apiKey error: \(error.localizedDescription)")
            return true
        }
    }
    
    /// 根据地址查询余额
    ///
    /// - Parameters:
    ///   - address:     钱包地址
    ///   - chain:      链的名称，比如eth-mainnet
    ///   - quoteCurrency: 要转换的货币。支持USD, CAD, EUR, SGD, INR, JPY, VND, CNY, KRW, RUB, TRY, NGN, ARS, AUD, CHF, and GBP.
    ///   - Returns: 返回一组TokenBalance
    func fetchTokenBalances(address: String, chain: String = "eth-mainnet", quoteCurrency: String = "USD") async throws -> ChainData<TokenBalance> {
        if isInvalidApiKey {
            throw NSError(domain: "InvalidApiKey", code: 404)
        }
        let walletAddress = address
        
        let urlStr = "https://api.covalenthq.com/v1/eth-mainnet/address/\(walletAddress)/balances_v2/"
        let headers: HTTPHeaders = [.authorization(bearerToken: apiKey)]
        let requst = AF.request(urlStr,
                                method: .get,
                                parameters: [
                                    "key": apiKey,
                                    "quote-currency": quoteCurrency,
                                    "page-size": 5
                                ], headers: headers)
        
        return try await withCheckedThrowingContinuation { continuation in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            requst.responseDecodable(of: ChainResponse<TokenBalance>.self, decoder: decoder) { response in
                switch response.result {
                case .success(let balanceResponse):
                    return continuation.resume(with: .success(balanceResponse.data))
                case .failure(let error):
                    return continuation.resume(throwing: error)
                }
            }
        }
        
    }
    
    // 查询代币转移记录
    func fetchTransactions(address: String, chain: String = "eth-mainnet", quoteCurrency: String = "USD", pageNumber: Int = 1, pageSize: Int = 20) async throws -> ChainData<TokenTransactionItem> {
        if isInvalidApiKey {
            throw NSError(domain: "InvalidApiKey", code: 404)
        }
        
        let walletAddress = address
    
        let urlStr = "https://api.covalenthq.com/v1/\(chain)/address/\(walletAddress)/transactions_v2/"
        let headers: HTTPHeaders = [.authorization(bearerToken: apiKey)]
        let requst = AF.request(urlStr,
                                method: .get,
                                parameters: [
                                    "key": apiKey,
                                    "quote-currency": quoteCurrency,
                                    "page-size": pageSize,
                                    "page-number": pageNumber
                                ], headers: headers)
        
        return try await withCheckedThrowingContinuation { continuation in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            requst.responseDecodable(of: ChainResponse<TokenTransactionItem>.self, decoder: decoder) { response in
                switch response.result {
                case .success(let txResponse):
                    return continuation.resume(with: .success(txResponse.data))
                case .failure(let error):
                    return continuation.resume(throwing: error)
                }
            }
        }
    }
    
    // 查询
    func fetchPortfolioHistory(address: String, chain: String = "eth-mainnet", quoteCurrency: String = "USD", days: Int = 30) async throws -> ChainData<ChartPointItem> {
        if isInvalidApiKey {
            throw NSError(domain: "InvalidApiKey", code: 404)
        }
        
        let walletAddress = address
    
        let urlStr = "https://api.covalenthq.com/v1/\(chain)/address/\(walletAddress)/portfolio_v2/"
        let headers: HTTPHeaders = [.authorization(bearerToken: apiKey)]
        let requst = AF.request(urlStr,
                                method: .get,
                                parameters: [
                                    "key": apiKey,
                                    "quote-currency": quoteCurrency,
                                    "days": days
                                ], headers: headers)
        return try await withCheckedThrowingContinuation { continuation in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            requst.responseDecodable(of: ChainResponse<ChartPointItem>.self, decoder: decoder) { response in
                switch response.result {
                case .success(let data):
                    return continuation.resume(with: .success(data.data))
                case .failure(let error):
                    return continuation.resume(throwing: error)
                }
            }
        }
    }
}

struct ChainResponse<Item: Codable>: Codable {
    let data: ChainData<Item>
    let error: Bool
    let error_message: String?
    let error_code: Int?
}

struct ChainData<Item: Codable>: Codable {
    var address: String?
    var chain_id: Int = 0
    var chain_name: String?
    var chain_tip_height: Int = 0
    var chain_tip_signed_at: String?
    var items = [Item]()
    var next_update_at: String?
    var pagination: Pagination?
    var quote_currency: String?
    var updated_at: String?
    
    struct Pagination: Codable {
        var has_more: Bool = false
        var page_number: Int = 0
        var page_size: Int = 0
        var total_count: Int? = 0
    }
    
}

// 一种代币的余额
struct TokenBalance: Codable, Identifiable {
    
    public var id: String {
        return "\(block_height)"
    }
    
    var balance: String?
    var balance_24h: String?
    var block_height: Int = 0
    var contract_address: String?
    var contract_decimals: Int?
    var contract_display_name: String?
    var contract_name: String?
    var contract_ticker_symbol: String?
    var is_spam: Bool = false
    var last_transferred_at: String?
    var logo_url: String?
    var logo_urls: TokenLogoURL?
    var native_token: Bool = false
    var nft_data: String?
    var pretty_quote: String?
    var pretty_quote_24h: String?
    var protocol_metadata: String?
    var quote: Double?
    var quote_24h: Double?
    var quote_rate: Double?
    var quote_rate_24h: Double?
    /*
     "supports_erc": [
     "erc20"
     ],
     */
    var supports_erc: [String]?
    var type: String?
    
    // 显示余额，例如11.9681818 ETH
    var displayTokenBalance: String {
        guard let balance else { return "" }
        let formattedBalance = formatTokenBalance(balance: balance, decimals: contract_decimals ?? 0, precision: 6)
        let str = "\(formattedBalance) \(contract_ticker_symbol ?? "")"
        return str
    }
    
    public static func == (lhs: TokenBalance, rhs: TokenBalance) -> Bool {
        return lhs.id == rhs.id
    }
    
}

// 交易记录
struct TokenTransactionItem: Codable, Identifiable {
    var id: String {
        return tx_hash ?? ""
    }
    
    var block_hash: String?
    var block_height: Int = 0
    var block_signed_at: String?
    var fees_paid: String?
    var from_address: String?
    var from_address_label: String?
    var gas_metadata: GasMetadata?
    var gas_offered: Int = 0
    var gas_price: Int = 0
    var gas_quote: Double = 0.0
    var gas_quote_rate: Float = 0.0
    var gas_spent: Int = 0
    var miner_address: String?
    var pretty_gas_quote: String?
    var pretty_value_quote: String?
    var successful: Bool = false
    var to_address: String?
    var to_address_label: String?
    var tx_hash: String?
    var tx_offset: Int = 0
    var value: String?
    var value_quote: Float = 0.0
    
    struct GasMetadata: Codable {
        var contract_address: String?
        var contract_decimals: Int = 0
        var contract_name: String?
        var contract_ticker_symbol: String?
        var logo_url: String?
        var supports_erc: [String]?
    }
    
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

struct TokenLogoURL: Codable {
    var chain_logo_url: String?
    var protocol_logo_url: String?
    var token_logo_url: String?
}

struct ChartPointItem: Codable {
    var contract_address: String?
    var contract_decimals: Int = 0
    var contract_name: String?
    var contract_ticker_symbol: String?
    var holdings = [ChartPointItemHoldings]()
    var logo_url: String?
}

struct ChartPointItemHoldings: Codable {
    // 收盘估值，用于趋势图，最常见
    var close: Point?
    // 最高估值,可用于绘制蜡烛图
    var high: Point?
    // 最低估值
    var low: Point?
    // 开盘估值,做开盘-收盘对比
    var open: Point?
    var quote_rate: Double?
    var timestamp: String?
    

    struct Point: Codable {
        var balance: String?
        var pretty_quote: String?
        var quote: Double?
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<ChartPointItemHoldings.Point.CodingKeys> = try decoder.container(keyedBy: ChartPointItemHoldings.Point.CodingKeys.self)
            
            self.balance = try container.decodeIfPresent(String.self, forKey: ChartPointItemHoldings.Point.CodingKeys.balance)
            self.pretty_quote = try container.decodeIfPresent(String.self, forKey: ChartPointItemHoldings.Point.CodingKeys.pretty_quote)
            
            // 解决Double类型的字段，接口返回NaN了
            if let quote = try? container.decodeIfPresent(Double.self, forKey: ChartPointItemHoldings.Point.CodingKeys.quote) {
                self.quote = quote
            } else {
                self.quote = nil
            }
        }
    }
}

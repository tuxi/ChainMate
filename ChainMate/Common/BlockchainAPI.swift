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
    
    var isInvaldApiKey: Bool {
        guard let apiKeyPath = Bundle.main.path(forResource: "api", ofType: "key") else {
            return false
        }
        do {
            var text = try String(contentsOf: URL(filePath: apiKeyPath), encoding: .utf8)
            if text.hasSuffix("\n") {
                text.removeLast()
            }
            self.apiKey = text
            return true
        } catch {
            print("Load apiKey error: \(error.localizedDescription)")
            return false
        }
    }
    
    // 根据地址查询余额
    // chain: The currency to convert. Supports USD, CAD, EUR, SGD, INR, JPY, VND, CNY, KRW, RUB, TRY, NGN, ARS, AUD, CHF, and GBP.
    func fetchTokenBalances(address: String, chain: String = "eth-mainnet", quoteCurrency: String = "USD") async throws -> [TokenBalance] {
        if !isInvaldApiKey {
            return []
        }
        let walletAddress = address
        
        let urlStr = "https://api.covalenthq.com/v1/\(chain)/address/\(walletAddress)/balances_v2/"
        
        let headers: HTTPHeaders = [.authorization(bearerToken: apiKey)]
        let requst = AF.request(urlStr,
                                method: .get,
                                parameters: [
                                    "key": apiKey,
                                    "quote-currency": quoteCurrency
                                ], headers: headers)
        
        return try await withCheckedThrowingContinuation { continuation in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            requst.responseDecodable(of: ChainResponse<TokenBalanceData>.self, decoder: decoder) { response in
                switch response.result {
                case .success(let balanceResponse):
                    return continuation.resume(with: .success(balanceResponse.data.items))
                case .failure(let error):
                    return continuation.resume(throwing: error)
                }
            }
        }
        
    }
}

struct ChainResponse<D: Codable>: Codable {
    let data: D
    let error: Bool
    let error_message: String?
    let error_code: Int?
}

struct TokenBalanceData: Codable {
    var address: String?
    var chain_id: Int = 0
    var chain_name: String?
    var chain_tip_height: Int = 0
    var chain_tip_signed_at: String?
    var items = [TokenBalance]()
    var next_update_at: String?
    var pagination: String?
    var quote_currency: String?
    var updated_at: String?
}

struct TokenBalance: Codable, Identifiable {
    
    public var id: String {
        return "\(block_height)"
    }
    
    var balance: String?
    var balance_24h: String?
    var block_height: Int = 0
    var contract_address: String?
    var contract_decimals: Int = 0
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
        let formattedBalance = formatTokenBalance(balance: balance, decimals: contract_decimals, precision: 6)
        let str = "\(formattedBalance) \(contract_ticker_symbol ?? "")"
        return str
    }
    
    public static func == (lhs: TokenBalance, rhs: TokenBalance) -> Bool {
        return lhs.id == rhs.id
    }
    
}

struct TokenLogoURL: Codable {
    var chain_logo_url: String?
    var protocol_logo_url: String?
    var token_logo_url: String?
}


//
//  BlockchainAPI.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/29.
//

import Foundation

class BlockchainAPI {
    static let shared = BlockchainAPI()
    private var apiKey: String = ""
    
    init() {
        guard let apiKeyPath = Bundle.main.path(forResource: "api", ofType: "key") else {
            return
        }
        do {
            let text = try String(contentsOf: URL(filePath: apiKeyPath), encoding: .utf8)
            self.apiKey = text
        } catch {
            print("Load apiKey error: \(error.localizedDescription)")
        }
    }
    
    func fetchTokenBalances(address: String, completion: @escaping ([TokenBalance]) -> ()) {
        guard let url = URL(string: "https://api.covalenthq.com/v1/1/address/\(address)/balances_v2/?key=\(apiKey)") else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {                
                    completion([])
                }
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(TokenBalance.self, from: data)
                DispatchQueue.main.async {
                    completion([decoded])
                }
            } catch {
                DispatchQueue.main.async {
                    print("decoded error: %\(error.localizedDescription)")
                    completion([])
                }
            }
        }
        task.resume()
    }
}

struct TokenBalance: Identifiable, Decodable {
    var id = UUID()
    let contract_name: String
    let contract_ticker_symbol: String
    let balance: String
    let quote: String
}

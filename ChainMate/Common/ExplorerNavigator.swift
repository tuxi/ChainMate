//
//  ExplorerNavigator.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/5.
//

import UIKit

struct ExplorerNavigator {
    // 跳转到交易记录详情
    static func openTransactionDetail(txHash: String, chainId: Int) {
        guard let chainId = ChainId(rawValue: chainId),
                let baseURL = chainId.baseURL else {
            print("不支持的链 ID：\(chainId)")
            return
        }
        let urlString = "\(baseURL)/tx/\(txHash)"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    // 打开地址详情
    static func openAddress(address: String, chainId: Int) {
        guard let chainId = ChainId(rawValue: chainId),
                let baseURL = chainId.baseURL else {
            print("不支持的链 ID：\(chainId)")
            return
        }
        let urlString = "\(baseURL)/address/\(address)"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

enum ChainId: Int {
    case etherscan = 1
    case bscscan = 56
    case polygonscan = 137
    case arbiscan = 42161
    case optimistic = 10
    case basescan = 8453
    
    var baseURL: String? {
        switch self {
        case .etherscan: return "https://etherscan.io"
        case .bscscan: return "https://bscscan.com"
        case .polygonscan: return "https://polygonscan.com"
        case .arbiscan: return "https://arbiscan.io"
        case .optimistic: return "https://optimistic.etherscan.io"
        case .basescan: return "https://basescan.org"
        }
    }
    
    var iconName: String {
        switch self {
        case .etherscan: return "bolt.fill"
        case .bscscan: return "flame.fill"
        case .polygonscan: return "triangle.fill"
        case .arbiscan: return "circlebadge.fill"
        case .optimistic: return "circle.grid.cross.fill"
        case .basescan: return "square.stack.3d.down.right.fill"
        }
    }
    
    var name: String {
        switch self {
        case .etherscan:
            return "Ethereum"
        case .bscscan:
            return "BNB Chain"
        case .polygonscan:
            return "Polygon"
        case .arbiscan:
            return "Arbitrum"
        case .optimistic:
            return "Optimism"
        case .basescan:
            return "Base"
        }
    }
}

//
//  RouterPath.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/26.
//

import Foundation

@MainActor
class RouterPath: ObservableObject {
    
    @Published var path: [Destination]
    
    init() {
        path = []
        
    }
    
    func navigate(to dst: Destination) {
        path.append(dst)
    }
    
    func pop() {
        if path.isEmpty {
            return
        }
        path.removeLast()
    }
}

extension RouterPath {
    
    // 路由的目标
    enum Destination: Hashable {
        case walletDetail(Wallet)
    }
}

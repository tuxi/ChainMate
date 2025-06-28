//
//  Wallet.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/26.
//

import Foundation

struct Wallet: Identifiable,Hashable {
    let id = UUID()
    let name: String
    var address: String
    // 备注名，默认无
    var remarks: String?
}

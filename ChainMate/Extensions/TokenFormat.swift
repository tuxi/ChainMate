//
//  TokenFormat.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/3.
//

import Foundation

/// 将链上原始字符串余额（如 "11960351134611185981"）按精度转换为浮点数，并格式化为字符串
/// precision 保留多少位小数
func formatTokenBalance(balance: String, decimals: Int, precision: Int = 6) -> String {
    guard let raw = Decimal(string: balance) else { return "0" }
    let divisor = pow(10, decimals)
    let actual = raw / divisor

    // 格式化为字符串，保留 precision 位小数
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = precision
    formatter.numberStyle = .decimal
    return formatter.string(for: actual) ?? "0"
}


extension Double {
    // 显示小数点清理
    var cleanValue: String {
        self.truncatingRemainder(dividingBy: 1) == 0 ?
        String(format: "%.0f", self) :
        String(format: "%.4f", self)
    }
}

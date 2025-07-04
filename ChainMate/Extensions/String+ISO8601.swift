//
//  String+ISO8601.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/4.
//

import Foundation

extension String {
    func formatISO8601() -> String {
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: self) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            return formatter.string(from: date)
        }
        return self
    }
}

//
//  TokenIconView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/8.
//

import SwiftUI
import Kingfisher

// 代币图标统一用TokenIconView
struct TokenIconView: View {
    let url: String
    let size: Double
    
    var body: some View {
        KFImage(URL(string: url))
                    .placeholder { Color.gray.opacity(0.2) }
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
    }
}

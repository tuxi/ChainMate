//
//  WalletRowView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/26.
//

import SwiftUI

struct WalletRowView: View {
    @State var wallet: Wallet
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(wallet.name)
                .font(.headline)
            Text(wallet.address)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    WalletRowView(wallet: .init(name: "Joy", address: "0xadsfsdf3..."))
}

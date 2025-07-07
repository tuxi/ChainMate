//
//  WalletHeaderView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/7.
//

import SwiftUI
import AlertToast

struct WalletHeaderView: View {
    let wallet: Wallet
    
    @Binding var isShowPasteSuss: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(wallet.name)
                .font(.title2)
                .bold()
            
            HStack {
                Text(wallet.address)
                    .font(.subheadline)
                    .foregroundStyle(Color(.gray))
                
                Button(action: {
                    UIPasteboard.general.string = wallet.address
                    isShowPasteSuss.toggle()
                }) {
                    Image(systemName: "doc.on.doc")
                }
            }
        }
    }
}

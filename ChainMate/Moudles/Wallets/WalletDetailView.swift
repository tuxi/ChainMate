//
//  WalletDetailView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/26.
//

import SwiftUI
import AlertToast

struct WalletDetailView: View {
    
    let wallet: Wallet
    @State var isShowPasteSuss = false
    
    @StateObject private var model = WalletDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 钱包名称和地址
                VStack(alignment: .leading) {
                    Text(wallet.name)
                        .font(.title2)
                        .bold()
                    HStack {
                        Text(shortAddress(wallet.address))
                            .font(.subheadline)
                            .foregroundStyle(Color(.gray))
                            
                        Button(action: {
                            UIPasteboard.general.string = wallet.address
                            isShowPasteSuss = true
                        }) {
                            Image(systemName: "doc.on.doc")
                        }
                    }
                }
                
                Divider()
                
                // 总资产估值
                VStack(alignment: .leading) {
                    Text("总资产估值")
                        .font(.headline)
                    Text("$12,345.67") // 静态数据，后面接API
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                }
                
                Divider()
            }
            .padding()
        }
        .toast(isPresenting: $isShowPasteSuss, alert: {
            AlertToast(displayMode: .alert, type: .regular, title: "已复制")
        })
        .onAppear {
            model.load(address: wallet.address)
        }
        .navigationTitle("钱包详情")
    }
    
    func shortAddress(_ address: String) -> String {
            let start = address.prefix(6)
            let end = address.suffix(4)
            return "\(start)...\(end)"
        }
}

#Preview {
    WalletDetailView(wallet: .init(name: "Joy", address: "0xadsfsdf3..."))
}

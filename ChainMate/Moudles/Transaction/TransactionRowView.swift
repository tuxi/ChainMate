//
//  TransactionRowView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/6.
//

import SwiftUI

struct TransactionRowView: View {
    
    @State var model: TokenTransactionItem?
    var walletAddress: String
    @State var chainId: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model?.block_signed_at?.formatISO8601() ?? "")
                .font(.caption)
                .foregroundStyle(.gray)

            
            HStack {
                Image(systemName: model?.successful == true ? "checkmark.circle" : "xmark.circle")
                    .foregroundStyle(model?.successful == true ? Color.green : Color.red)
                Text(model?.from_address == walletAddress.lowercased() ? "→ 发送交易" : "← 接收交易")
                                .font(.subheadline)
                
                Spacer()
                Text("\(formatTokenBalance(balance: model?.value ?? "", decimals: 18)) ETH")
                                .font(.subheadline)
                                .bold()
                
            }
            
            Button {
                if let model = model, let chain = chainId, let txHash = model.tx_hash {
                    ExplorerNavigator.openTransactionDetail(txHash: txHash, chainId: chain)
                }
            } label: {
                HStack(spacing: 4) {
                    Image(systemName: "link")
                    Text("查看区块链浏览器")
                }
                .font(.caption)
                .foregroundColor(.blue)
            }

        }
        .padding(.vertical, 4)
    }
}

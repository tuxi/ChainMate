//
//  AddWalletView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/27.
//

import SwiftUI

struct AddWalletView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var wallets: [Wallet]
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("例如：主钱包", text: $name)
                } header: {
                    Text("钱包名称")
                }

                Section {
                    TextField("例如：0x1234...", text: $address)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                } header: {
                    Text("钱包地址")
                }

            }
            .alert("无效地址", isPresented: $showError, presenting: nil, actions: {
                Button("好的") {
                    showError = false
                }
            }, message: {
                Text("Thank you for shopping with us.")
            })
            .navigationTitle("添加钱包")
            .navigationBarItems(
                leading: Button("取消") {
                    presentationMode.wrappedValue.dismiss()
                },trailing: Button("保存") {
                    let trimmed = address.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !trimmed.isEmpty && trimmed.hasPrefix("0x") {
                        wallets.append(Wallet(name: name, address: trimmed))
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        showError = true
                    }
                }
                    .disabled(name.isEmpty || address.isEmpty)
                                    
            )
        }
    }
}

#Preview {
    var wallets: [Wallet] = []
    return AddWalletView(wallets: .init(get: {
        return wallets
    }, set: {
        wallets = $0
    }))
}

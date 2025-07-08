//
//  Tabs.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/26.
//

import Foundation
import SwiftUI

enum Tab: Int, Identifiable, Hashable {
    case wallets
    case settings
    case markets
    
    var id: Int {
        return rawValue
    }
    
    @ViewBuilder
    func makeContentView(rootTab: Binding<Tab>) -> some View {
        switch self {
        case .wallets:
            WalletListView()
        case .markets:
            MarketView()
        default:
            SettingsView()
        }
    }
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .wallets:
            Label("Wallets", systemImage: "square.stack")
        case .markets:
            Label("Markets", systemImage: "square.stack")
        case .settings:
            Label("Swttings", systemImage: "gearshape")
        }
    }
}

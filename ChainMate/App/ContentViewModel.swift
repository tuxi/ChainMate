//
//  ContentViewModel.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/26.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var selectedTab: Tab = .wallets
    @Published var popToRootTab: Tab = .settings
    
    var availableTabs: [Tab] {
        return [.wallets, .settings]
    }
}

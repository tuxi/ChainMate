//
//  ContentView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/6/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ContentViewModel 
    
    var body: some View {
        tabView
    }
    
    var tabView: some View {
        TabView(selection: .init(get: {
            viewModel.selectedTab
        }, set: {
            viewModel.selectedTab = $0
        }),
                content:  {
            ForEach(viewModel.availableTabs) { tab in
                tab.makeContentView(rootTab: $viewModel.popToRootTab)
                    .tabItem {
                        tab.label
                            .labelStyle(TitleAndIconLabelStyle())
                    }
                    .tag(tab)
                
            }
        })
        
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}

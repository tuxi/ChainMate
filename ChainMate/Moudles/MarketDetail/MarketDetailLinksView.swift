//
//  MarketDetailLinksView.swift
//  ChainMate
//
//  Created by xiaoyuan on 2025/7/10.
//

import SwiftUI

struct MarketDetailLinksView: View {
    
    let info: CoinDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("相关链接")
                .font(.headline)
            
            // 链接
            if let homepage = info.links?.homepage?.first, !homepage.isEmpty {
                LinkRow(title: "官网", url: homepage)
            }
            if let explorer = info.links?.blockchainSite?.first(where: { !$0.isEmpty }) {
                LinkRow(title: "区块浏览器", url: explorer)
            }
            if let forum = info.links?.officialForumUrl?.first, !forum.isEmpty {
                LinkRow(title: "官方论坛", url: forum)
            }
            if let twitter = info.links?.twitterScreenName {
                LinkRow(title: "Twitter", url: "https://twitter.com/\(twitter)")
            }
            if let reddit = info.links?.subredditUrl {
                LinkRow(title: "Reddit", url: reddit)
            }
            if let github = info.links?.reposUrl?.github?.first {
                LinkRow(title: "GitHub", url: github)
            }
        }
    }
}

struct LinkRow: View {
    let title: String
    let url: String

    var body: some View {
        HStack {
            Image(systemName: "link")
            Link(title, destination: URL(string: url)!)
            Spacer()
        }
    }
}

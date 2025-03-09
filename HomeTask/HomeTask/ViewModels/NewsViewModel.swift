//
//  NewsViewModel.swift
//  HGithubClient
//
//  Created by 林彩霞 on 2025/3/8.
//

import SwiftUI
@preconcurrency import FeedKit

final class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []

    func fetchNews() async {
        guard let url = URL(string: AppConstants.Network.newsURL) else { return }

        let parser = FeedParser(URL: url)
        
        parser.parseAsync { [weak self] result in
            switch result {
            case .success(let feed):
                if let rssFeed = feed.rssFeed {
                    DispatchQueue.main.async {
                        self?.articles = rssFeed.items?.compactMap { item in
                            NewsArticle(
                                title: item.title ?? "No title",
                                description: item.description?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "No description",
                                link: URL(string: item.link ?? "")
                            )
                        } ?? []
                    }
                }
            case .failure(let error):
                print("Error parsing feed: \(error)")
            }
        }
    }
}

struct NewsArticle: Hashable {
    let title: String
    let description: String
    let link: URL?
    
    var cleanedDescription: String {
        return description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

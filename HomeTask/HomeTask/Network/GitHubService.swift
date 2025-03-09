//
//  GitHubService.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/8.
//

import Foundation

// define a github search service protocol
protocol GitHubSearchService {
    func searchRepositories(query: String) async throws -> SearchResults
}

// implement GitHubSearchService
class DefaultGitHubSearchService: GitHubSearchService {
    func searchRepositories(query: String) async throws -> SearchResults {
        // configure url
        let searchURLString = "https://api.github.com/search/repositories?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
        guard let url = URL(string: searchURLString) else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        
        // request
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // parse json data
        let decoder = JSONDecoder()
        return try decoder.decode(SearchResults.self, from: data)
    }
}

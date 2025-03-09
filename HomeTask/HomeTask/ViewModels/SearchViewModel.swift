//
//  SearchViewModel.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/7.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var results: [Repository] = []
    @Published var errorMessage: String?
    
    // inject GitHub search service
    var searchService: GitHubSearchService
    
    init(results: [Repository] = [], errorMessage: String? = nil, searchService: GitHubSearchService = DefaultGitHubSearchService()) {
        self.results = results
        self.errorMessage = errorMessage
        self.searchService = searchService
    }
    
    @MainActor
    func searchGitHub(query: String) async {
        do {
            // do search
            let result = try await searchService.searchRepositories(query: query)
            results = result.items
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

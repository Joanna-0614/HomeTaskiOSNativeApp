//
//  SearchViewModelTests.swift
//  HomeTaskTests
//
//  Created by 林彩霞 on 2025/3/9.
//

import XCTest
@testable import HomeTask

final class SearchViewModelTests: XCTestCase {

    var searchViewModel: SearchViewModel!
    var mockGitHubService: MockGitHubSearchService!

    override func setUpWithError() throws {
        mockGitHubService = MockGitHubSearchService()
        searchViewModel = SearchViewModel(searchService: mockGitHubService)
    }

    override func tearDownWithError() throws {
        searchViewModel = nil
        mockGitHubService = nil
    }

    func testSearchGitHub() async throws {
        let query = "testQuery"
        await searchViewModel.searchGitHub(query: query)
        XCTAssertNotNil(searchViewModel.results, "Search results should not be nil after a search")
    }
}

class MockGitHubSearchService: GitHubSearchService {
    func searchRepositories(query: String) async throws -> SearchResults {
        let mockData = try loadMockData(from: "mock_search_results")
        let decoder = JSONDecoder()
        return try decoder.decode(SearchResults.self, from: mockData)
    }

    private func loadMockData(from fileName: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "MockDataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock data file not found"])
        }
        return try Data(contentsOf: url)
    }
}

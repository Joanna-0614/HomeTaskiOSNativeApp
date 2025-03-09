//
//  SearchView.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/7.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    
    @State private var searchText = ""
    @State private var searchResults: [Repository] = []
    @State private var isSearching = false
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, isSearching: $isSearching, onSearch: performSearch)
            Spacer()
            
            if let error = searchViewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else if isSearching {
                ProgressView()
                    .padding()
            } else {
                List(searchResults) { repo in
                    NavigationLink(destination: RepoDetailView(repo: repo)) {
                        VStack(alignment: .leading) {
                            Text(repo.name)
                                .font(.headline)
                            Text(repo.fullName)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    private func performSearch() async {
        isSearching = true
        searchViewModel.errorMessage = nil
        
        await searchViewModel.searchGitHub(query: searchText)
        searchResults = searchViewModel.results
        isSearching = false
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    var onSearch: () async -> Void
    
    var body: some View {
        HStack {
            TextField("Search repositories", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.title3)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                       .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
            
            Button(action: {
                Task {
                    await onSearch()
                }
            }) {
                Image(systemName: "magnifyingglass")
            }
            .padding(.trailing)
        }
    }
}

struct RepoDetailView: View {
    let repo: Repository
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(repo.fullName)
                    .font(.largeTitle)
                    .padding()
                
                if let description = repo.description {
                    Text(description)
                        .font(.body)
                        .padding()
                }
                
                Link("View on GitHub", destination: URL(string: repo.htmlUrl)!)
                    .padding()
            }
        }
        .navigationTitle(repo.name)
    }
}

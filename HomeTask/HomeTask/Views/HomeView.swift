//
//  HomeView.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/7.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var newsViewModel = NewsViewModel()
    @State private var showingLoginView = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                    Text("Welcome to GitHub Client App")
                    
                    imageCardView
                        .padding(.horizontal)
                    
                    NavigationLink(destination: SearchView()) {
                        Text("Search")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(5.0)
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(newsViewModel.articles.prefix(4), id: \.self) { article in
                            NavigationLink(destination: NewsDetailView(article: article)) {
                                NewsCardView(article: article)
                            }
                        }
                    }
                    .padding()
                    .onAppear {
                        Task {
                            await newsViewModel.fetchNews()
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        let profileView = ProfileView().environmentObject(authViewModel)
                        NavigationLink(destination: profileView) {
                            Text("Profile")
                        }
                        .disabled(authViewModel.isLoggedIn == false)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if authViewModel.isLoggedIn {
                                Task {
                                    await authViewModel.logout()
                                }
                                showingLoginView = false
                            } else {
                                showingLoginView = true
                            }
                        }) {
                            Text(authViewModel.isLoggedIn ? "Logout" : "Login")
                        }
                    }
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $showingLoginView) {
                    LoginView(showingLoginView: $showingLoginView)
                        .environmentObject(authViewModel)
                }
            }
        }
    }
    
    @ViewBuilder
    var imageCardView: some View {
        HStack {
            // load success image
            ImageCard(url: AppConstants.Network.imageSuccessURL) // valid url
                .frame(height: 100)
                .cornerRadius(10)
                .shadow(radius: 4)
            
            // load failure image
            ImageCard(url: AppConstants.Network.imageFailureURL) // force to use invalid url
                .frame(width: 150, height: 100)
                .cornerRadius(10)
                .shadow(radius: 4)
        }
    }
}

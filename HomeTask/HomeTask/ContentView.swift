//
//  ContentView.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/7.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        HomeView()
            .environmentObject(authViewModel)
    }
}

#Preview {
    ContentView()
}

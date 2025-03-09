//
//  NewsDetailView.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/8.
//

import SwiftUI

struct NewsDetailView: View {
    let article: NewsArticle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(article.title)
                .font(.largeTitle)
                .bold()
            Text(article.description)
                .font(.body)
            
            Spacer()
            
            if let link = article.link {
                Link("Read more", destination: link)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

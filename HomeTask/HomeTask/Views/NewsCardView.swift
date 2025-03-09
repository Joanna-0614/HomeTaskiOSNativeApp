//
//  NewsCardView.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/8.
//

import SwiftUI

struct NewsCardView: View {
    let article: NewsArticle
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.bottom, 2)
            Text(article.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(3)
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

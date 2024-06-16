//
//  NewsPage.swift
//  NewsApp+
//
//  Created by valeri mekhashishvili on 16.06.24.
//

import SwiftUI

struct NewsPage: View {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.articles) { article in
                NavigationLink(destination: DetailsView(article: article)) {
                    HStack {
                        if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 80, height: 80)
                                     .clipped()
                            } placeholder: {
                                Color.gray
                                    .frame(width: 80, height: 80)
                            }
                        }
                        
                        Text(article.title)
                            .font(.headline)
                            .lineLimit(3)
                    }
                }
            }
            .navigationTitle("News")
            .onAppear {
                networkManager.fetchNews()
            }
        }
    }
}


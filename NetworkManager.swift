//
//  NetworkManager.swift
//  NewsApp+
//
//  Created by valeri mekhashishvili on 16.06.24.
//

import Foundation

struct Article: Decodable, Identifiable {
    let id = UUID()
    let title: String
    let description: String?
    let urlToImage: String?
    let author: String?
    let publishedAt: String?
}

struct NewsResponse: Decodable {
    let articles: [Article]
}

class NetworkManager: ObservableObject {
    @Published var articles: [Article] = []
    private let apiKey = "9c163e5edef146b497b38054c6f0cfcd"
    
    func fetchNews() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let newsResponse = try? decoder.decode(NewsResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.articles = newsResponse.articles
                    }
                }
            }
        }.resume()
    }
}

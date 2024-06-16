//
//  UIViewControllerRepresentable.swift
//  NewsApp+
//
//  Created by valeri mekhashishvili on 16.06.24.
//
import UIKit
import SwiftUI

struct DetailsView: UIViewControllerRepresentable {
    let article: Article
    
    func makeUIViewController(context: Context) -> UIViewController {
        return DetailsViewController(article: article)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

class DetailsViewController: UIViewController {
    var article: Article
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = article.title
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 0
        
        let imageView = UIImageView()
        if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = article.description
        descriptionLabel.numberOfLines = 0
        
        let authorLabel = UILabel()
        authorLabel.text = "Author: \(article.author ?? "Unknown")"
        
        let dateLabel = UILabel()
        dateLabel.text = "Published at: \(article.publishedAt ?? "Unknown")"
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView, descriptionLabel, authorLabel, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
}

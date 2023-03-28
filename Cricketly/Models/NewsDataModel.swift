//
//  NewsDataModel.swift
//  Cricketly
//
//  Created by BJIT  on 25/2/23.
//

import Foundation

// MARK: - NewsDataModel
class NewsDataModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?

    init(status: String?, totalResults: Int?, articles: [Article]?) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

// MARK: - Article
class Article: Codable {
    let source: Source?
    let author: String?
    let title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    init(source: Source?, author: String?, title: String?, description: String?, url: String?, urlToImage: String?, publishedAt: String?, content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

// MARK: - Source
class Source: Codable {
    let id: String?
    let name: String?

    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
}

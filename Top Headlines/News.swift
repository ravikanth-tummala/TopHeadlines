//
//  News.swift
//  Top Headlines
//
//  Created by GeoSpark on 05/08/21.
//

import Foundation

struct News: Codable {
    struct Article: Codable {
        struct Source: Codable {
            let name: String
        }
        let source: Source
        let author: String?
        let title: String
        let description: String?
        let url: URL
        let urlToImage: URL?
        let publishedAt: Date
    }
    let articles: [Article]
}

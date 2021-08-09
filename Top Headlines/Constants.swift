//
//  Constants.swift
//  Top Headlines
//
//  Created by GeoSpark on 05/08/21.
//

import Foundation

// https://newsapi.org/v2/top-headlines?country=us&apiKey=xxxxxxxxxxxxxxxxxxxxxx
//#warning("Make sure you add your key")
enum Constants {
    static let baseURL = "https://newsapi.org/v2/top-headlines"
    static let country = "ca"
    static let apiKey = "e6cb5f6a1f1e4017b8289a9bc07c7ec1"
    static var endPoint: String {
        Self.baseURL + "?country=" + Self.country + "&apiKey=" + Self.apiKey
    }
}

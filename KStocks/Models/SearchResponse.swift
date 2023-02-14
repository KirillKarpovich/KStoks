//
//  SearchResponse.swift
//  KStocks
//
//  Created by Kirill Karpovich on 14.02.23.
//

import Foundation

struct SearchResponse: Codable {
    let count: Int
    let result: [SearchResult]
}

struct SearchResult: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}

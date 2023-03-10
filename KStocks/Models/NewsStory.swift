//
//  NewsStory.swift
//  KStocks
//
//  Created by Kirill Karpovich on 16.02.23.
//

import Foundation

struct NewsStory: Codable {
    let category: String
    let datetime: TimeInterval
    let headline: String
    let id: Int
    let image: String
    let related: String
    let source: String
    let summary: String
    let url: String
}

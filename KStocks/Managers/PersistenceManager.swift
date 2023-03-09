//
//  PersistenceManager.swift
//  KStocks
//
//  Created by Kirill Karpovich on 13.02.23.
//

import Foundation

final class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let userDefaults: UserDefaults = .standard
    
    private struct Constants {
        static let onboardedKey = "hasOnboarded"
        static let watchlistKey = "watchlist"

    }
    
    private init() {}
    
    public var watchlist: [String] {
        if !hasOnboarded {
            userDefaults.set(true, forKey: Constants.onboardedKey)
            setupDeafults()
        }
        
        return userDefaults.stringArray(forKey: Constants.watchlistKey) ?? []
    }
    
    public func addToWatchlist() {
    }
    
    public func removeFromWatchlist() {
    }
        
    private var hasOnboarded: Bool {
        return userDefaults.bool(forKey:Constants.onboardedKey)
    }
    
    private func setupDeafults() {
        let map: [String: String] = [
            "AAPL": "Apple Inc.",
            "MSFT": "Microfost Corporation",
            "GOOG": "Alphabet",
            "AMZN": "Amazon.com Inc.",
            "WORK": "Slack Technologies",
            "FB": "Facebook Inc.",
            "NVDA": "Nvidia Inc",
            "NKE": "Nike",
            "PINS": "Pinterest Inc."
        ]
        let symbols = map.keys.map{ $0 }
        userDefaults.set(symbols, forKey: Constants.watchlistKey)
        
        for (symbol, name) in map {
            userDefaults.set(name, forKey: symbol)
        }
    }
}

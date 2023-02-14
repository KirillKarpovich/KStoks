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
        
    }
    
    private init() {}
    
    public var watchlist: [String] {
        return []
    }
    
    public func addToWatchlist() {
        
    }
    
    public func removeFromWatchlist() {
//        print("Test")
    }
}

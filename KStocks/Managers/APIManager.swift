//
//  APIManager.swift
//  KStocks
//
//  Created by Kirill Karpovich on 13.02.23.
//

import Foundation

final class APIManager {
    static let shared = APIManager()
    
    private struct Constants {
        static let apiKey = "cflo599r01qjfr8f2dj0cflo599r01qjfr8f2djg"
        static let sandboxApiKey = ""
        static let baseUrl = "https://finnhub.io/api/v1/"
    }
    
    private init() {}
    
    public func search(
        query: String,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    ) {
       request(
        url: url(
            for: .search,
            queryParams: ["q":query]
    ),
        expecting: SearchResponse.self, completion: completion)
    }
    
    private enum Endpoint: String {
        case search
    }
    
    private enum APIError: Error {
        case invalidUrl
        case noDataReturned
    }
    
    private func url(
        for endpoint: Endpoint,
        queryParams: [String:String] = [:]
    ) -> URL? {
        var urlString = Constants.baseUrl + endpoint.rawValue
        
        var queryItems = [URLQueryItem]()
        // Add any parametrs
        for (name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        //Add token
        queryItems.append(.init(name: "token", value: Constants.apiKey))
        
        // Convert query items to suffix string
        let queryString = queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
        
        urlString += "?" + queryString
        print("\n\(urlString)\n")
        return URL(string: urlString)
    }
    
    private func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(APIError.invalidUrl))
            return
            
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.noDataReturned))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

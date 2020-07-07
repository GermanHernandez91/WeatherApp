//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by German Hernandez on 07/07/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

final class NetworkManager: NetworkProtocol {
    
    func get(with path: String, method: HTTPMethod, parameters: Parameters?, completion: @escaping NetworkResult) {
        
        guard var url = URL(string: path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        if let parameters = parameters {
            var queryItems: [URLQueryItem] = []
            
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = queryItems
            
            guard let urlFormatted = urlComponents?.url else {
                completion(.failure(.urlBadFormatted))
                return
            }
            
            url = urlFormatted
        }
        
         print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        print(url)
        
        performTask(with: request) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { completion(.success(data)) }
            case .failure(let error):
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
}

private extension NetworkManager {
    
    func performTask(with request: URLRequest, completion: @escaping NetworkResult) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completion(.failure(.internetConnection))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}

//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by German Hernandez on 07/07/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

enum WeatherEndpoints: String {
    case current = "/current.json"
}

final class WeatherAPI: WeatherAPIProtocol {
  
    private var networkManager: NetworkProtocol!
    private var endpoint: String!
    
    init(networkManager: NetworkManager, endpoint: WeatherEndpoints) {
        self.networkManager = networkManager
        self.endpoint = Constants.baseURL + endpoint.rawValue
    }
    
    func getCurrentForecast(lat: Double, lon: Double, completion: @escaping (Result<Weather, NetworkError>) -> Void) {
    
        // let parameters: Parameters = ["key": Constants.apiKey, "q": "\(lat), \(lon)"]
        let parameters: Parameters = ["key": Constants.apiKey, "q": "Glasgow"]
        
        networkManager.get(with: endpoint, method: .get, parameters: parameters) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Weather.self, from: data)
                    completion(.success(response))
                } catch {
                    print(error)
                    completion(.failure(.invalidData))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

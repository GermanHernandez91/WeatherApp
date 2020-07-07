//
//  NetworkProtocol.swift
//  WeatherApp
//
//  Created by German Hernandez on 07/07/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    func get(with path: String, method: HTTPMethod, parameters: Parameters?, completion: @escaping NetworkResult) -> Void
}

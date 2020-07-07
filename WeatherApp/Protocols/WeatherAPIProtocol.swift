//
//  WeatherAPIProtocol.swift
//  WeatherApp
//
//  Created by German Hernandez on 07/07/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

protocol WeatherAPIProtocol {
    func getCurrentForecast(lat: Double, lon: Double, completion: @escaping(Result<Weather, NetworkError>) -> Void)
}

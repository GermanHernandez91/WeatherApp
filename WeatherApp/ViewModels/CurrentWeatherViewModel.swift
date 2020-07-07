//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by German Hernandez on 07/07/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation
import Combine

protocol CurrentWeatherViewModelProtocol: ObservableObject {
    func fetchCurrentWeatherData(lat: Double, lon: Double)
    func getWeatherIcon(code: Int) -> String
}

final class CurrentWeatherViewModel: CurrentWeatherViewModelProtocol {
    
    @Published var weather: Weather?
    @Published var error: String = ""
    @Published var showError: Bool = false
    
    private var weatherAPI: WeatherAPIProtocol!
    
    init(weatherAPI: WeatherAPIProtocol) {
        self.weatherAPI = weatherAPI
    }
    
    func fetchCurrentWeatherData(lat: Double, lon: Double) {
        
        weatherAPI.getCurrentForecast(lat: lat, lon: lon) { result in
            switch result {
            case .success(let weather):
                print(weather)
                self.weather = weather
                
            case .failure(let error):
                print(error)
                self.error = error.rawValue
                self.showError = true
            }
        }
    }
    
    func getWeatherIcon(code: Int) -> String {
        print(code)
        switch code {
        case 1183:
            return "cloud.rain"
        default:
            return "sun.max"
        }
    }
}

//
//  Errors.swift
//  WeatherApp
//
//  Created by German Hernandez on 07/07/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: String, Error {
    case invalidURL = "URL provided is invalid"
    case urlBadFormatted = "URL is bad formatted, please check the parameters"
    case genericError = "Something went wrong"
    case internetConnection = "Unable to complete. Check your internet connection"
    case invalidResponse = "Invalid response from the server"
    case invalidData = "Invalid data from the server"
}

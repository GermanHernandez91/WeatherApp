//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by German Hernandez on 07/07/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

final class LocationViewModel: NSObject, ObservableObject {
    
    @Published var userLatitude: Double = 0
    @Published var userLongitude: Double = 0
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
        print(location)
    }
}

//
//  ContentView.swift
//  WeatherApp
//
//  Created by German Hernandez on 07/07/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var locationViewModel = LocationViewModel()
    @ObservedObject var viewModel = CurrentWeatherViewModel(weatherAPI: WeatherAPI(networkManager: NetworkManager(), endpoint: .current))
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(Date().convertToMonthYearFormat())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        HStack {
                            Image(systemName: viewModel.getWeatherIcon(code: viewModel.weather?.current.condition.code ?? 0))
                            Text(viewModel.weather?.current.condition.text ?? "Unknow")
                            
                        }
                        .font(.system(size: 24))
                        .padding(.top, 15)
                    }
                    Spacer()
                    Text("\(viewModel.weather?.current.tempC ?? 0, specifier: "%.1f")º")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.blue)
                }
                
                HStack {
                    Text("Additional information")
                        .font(.headline)
                    Spacer()
                }
                .padding(.top, 30)
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Humidity")
                        Text("\(viewModel.weather?.current.humidity ?? 0)%")
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Cloud")
                        Text("\(viewModel.weather?.current.cloud ?? 0)%")
                    }
                }
                .padding(.top, 30)
                
                 Divider()
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .navigationBarTitle(viewModel.weather?.location.region ?? "Unknow")
        }
        .onAppear {
            self.viewModel.fetchCurrentWeatherData(
                lat: self.locationViewModel.userLatitude,
                lon: self.locationViewModel.userLongitude
            )
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text(viewModel.error))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

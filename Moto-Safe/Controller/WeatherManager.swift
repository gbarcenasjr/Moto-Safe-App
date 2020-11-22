//
//  WeatherManager.swift
//  Moto-Safe
//
//  Created by user186085 on 11/21/20.
//


import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=6f9ce809622d19652b83a7437026446b&units=imperial"
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
    }
}

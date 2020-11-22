//
//  WeatherData.swift
//  Moto-Safe
//
//  Created by user186085 on 11/21/20.
//


import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Decodable {
    let temp: Double //tValue
    let pressure: Double //pValue
}

struct Weather: Decodable {
    let main: String
    let description: String
    let id: Int  // weValue
}

struct Wind: Decodable {
    let speed: Double //wiValue
}

struct usefulValues{
    static var weaValue = ""
    static var weValue = 0
    static var pValue = 0.0
    static var tValue = 0.0
    static var wiValue = 0.0
    
    
}

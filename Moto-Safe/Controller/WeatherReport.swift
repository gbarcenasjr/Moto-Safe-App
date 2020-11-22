//
//  WeatherReport.swift
//  Moto-Safe
//
//  Created by user186085 on 11/21/20.
//

import Foundation

struct WeatherReport {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6f9ce809622d19652b83a7437026446b&units=imperial"
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest (urlString: String){
        //1. Creat a URL
        if let url = URL(string: urlString){
            
            //2. URL Session
            let session = URLSession(configuration: .default)
        
            //3.Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print (error!)
                    return
                }
                
                if let safeData =  data {
                    self.parseJSON(weatherData: safeData)
                }
                
            }
            
            //4. Start the Task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            usefulValues.weaValue = decodedData.weather[0].main
            usefulValues.weValue = decodedData.weather[0].id
            usefulValues.wiValue = decodedData.wind.speed
            usefulValues.pValue = decodedData.main.pressure
            usefulValues.tValue = decodedData.main.temp
            
        } catch {
            print(error)
        }
    }
    
}

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
        //print("It works here. 1")  //1st
        performRequest(urlString: urlString)
        //print("It works here. 6")  // 6t
    }
    
    func performRequest (urlString: String){
        //1. Creat a URL
        if let url = URL(string: urlString){
            //print("It works here. 2") //2nd
            //2. URL Session
            let session = URLSession(configuration: .default)
            //print("It works here. 7") //3rd
        
            
            
            //3.Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print (error!)
                    return
                }
                
                if let safeData =  data {
                    //print("It works here. 8") //7th
                    self.parseJSON(weatherData: safeData)
                    //print("It works here. 3") //10
                }
                
            }
            
            //4. Start the Task
            //print("It works here. 9")  //4th
            task.resume()
            //print("It works here. 4")  //5th
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            //print("It works here. 5")  //8th
            usefulValues.weaValue = decodedData.weather[0].main
            usefulValues.weValue = decodedData.weather[0].id
            usefulValues.wiValue = decodedData.wind.speed
            usefulValues.pValue = decodedData.main.pressure
            usefulValues.tValue = decodedData.main.temp
            //print("It works here. 10")  //9th
            
        } catch {
            print(error)
        }
    }
    
}

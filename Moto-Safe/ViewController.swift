//
//  ViewController.swift
//  Moto-Safe
//
//  Created by Gerardo Barcenas Jr. on 11/17/20.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    //IB Outlet List is Decending according to vertical Position
    @IBOutlet weak var topBanner: UIView! // "Moto-Safe" Banner at the top
    @IBOutlet weak var searchTextField: UITextField! //"Enter City" Text Field
    @IBOutlet weak var rideScoreBanner: UIView!  //The background of the Ride Score Text
    @IBOutlet weak var rideScoreResult: UILabel!  //The Ride Score Text
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!  //The Color Coded Weather Title
    @IBOutlet weak var weatherResult: UILabel!  //The actual weather report
    @IBOutlet weak var rainLabel: UILabel!  //The Color Coded Chance of Rain Title
    @IBOutlet weak var rainResult: UILabel!  //The actual Chance of Rain report
    @IBOutlet weak var tempLabel: UILabel!  //The Color Coded Temperature Title
    @IBOutlet weak var tempResult: UILabel!  //The actual Temperature report
    @IBOutlet weak var timeLabel: UILabel!  //The Color Coded Time Title
    @IBOutlet weak var timeResult: UILabel!  //The Current Time
    @IBOutlet weak var windLabel: UILabel!  //The Color Coded Wind Speed Title
    @IBOutlet weak var windResult: UILabel!  //The actual Wind Speed report
    @IBOutlet weak var creditBanner: UIView!  //The Banner with my name on it
    
    var weatherManager = WeatherReport()
    var avgScore = 75.5
    var weatherScore = 75.5
    var rainScore = 75.5
    var tempScore = 75.5
    var timeScore = 75.5
    var windScore = 75.5
    
    override func viewDidLoad() { //Initiates as soon as the app Launches
        super.viewDidLoad()
        
        searchTextField.delegate = self //Gives itself more text functionality
    }

    @IBAction func searchPressed(_ sender: UIButton) {  //When User presses the Blue Search Image
        changeLabels()
        searchTextField.endEditing(true)  //Puts away Keyboard
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //When User presses "Go"
        changeLabels()
        searchTextField.endEditing(true) //Puts away Keyboard
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //Check to see the User Typed Something
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please Enter a City"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {  //Activates after User Input
        
        cityName.text = "\(searchTextField.text!)"
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
    func changeLabels() {
        //WEATHER
        weatherResult.text = usefulValues.weaValue
        if weatherResult.text == "Rain" ||  weatherResult.text == "Drizzle" || weatherResult.text == "Snow" || weatherResult.text == "Extreme"{
            weatherScore = 75
            weatherLabel.textColor = UIColor(named: "Risky Color Code")
        } else {
            weatherScore = 95
            weatherLabel.textColor = UIColor(named: "Safe Color Code")
        }
        
        //TEMP
        tempResult.text = "\(usefulValues.tValue)°F"
        tempScore = 100 - pow(abs(75.0 - Double(usefulValues.tValue)),1.1)
        if tempScore >= 90 {
            tempLabel.textColor = UIColor(named: "Safe Color Code")
        } else if tempScore >= 80 {
            tempLabel.textColor = UIColor(named: "Uncomfortable Color Code")
        } else if tempScore >= 70 {
            tempLabel.textColor = UIColor(named: "Risky Color Code")
        } else {
            tempLabel.textColor = UIColor(named: "Very Risky Color Code")
        }
        
        //WIND
        windResult.text = "\(usefulValues.wiValue) mph"
        windScore = 100 - usefulValues.wiValue
        if windScore >= 90 {
            windLabel.textColor = UIColor(named: "Safe Color Code")
        } else if windScore >= 80 {
            windLabel.textColor = UIColor(named: "Uncomfortable Color Code")
        } else if windScore >= 70 {
            windLabel.textColor = UIColor(named: "Risky Color Code")
        } else {
            windLabel.textColor = UIColor(named: "Very Risky Color Code")
        }
        
        
        //CHANCE OF RAIN
        if  (usefulValues.weValue >= 200 && usefulValues.weValue <= 232) || (usefulValues.weValue >= 600 && usefulValues.weValue <= 622){
            rainResult.text = "High"
            rainScore = 50
            rainLabel.textColor = UIColor(named: "Risky Color Code")
        } else if usefulValues.weValue >= 500 && usefulValues.weValue <= 531 {
            rainResult.text = "Medium"
            rainScore = 75
            rainLabel.textColor = UIColor(named: "Uncomfortable Color Code")
        } else {
            rainResult.text = "Low"
            rainScore = 95
            rainLabel.textColor = UIColor(named: "Safe Color Code")
        }
        
        //TIME
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let dateTimeString = formatter.string(from: currentDateTime)
        timeResult.text = dateTimeString
        
        let hour = dateTimeString
        let endOfSentence1 = hour.firstIndex(of: ":")!
        let hourTime = hour[...endOfSentence1]
        
        let period = dateTimeString
        let endOfSentence2 = period.firstIndex(of: "M")!
        let beginingOfSentence = period.firstIndex(of: " ")!
        let periodTime = period[beginingOfSentence...endOfSentence2]
        
        if  (String(hourTime) == "11:"  && String(periodTime) == " PM")  || (String(hourTime) == "12:" || String(hourTime) == "1:" || String(hourTime) == "2:" || String(hourTime) == "3:" || String(hourTime) == "4:" || String(hourTime) == "5:" || String(hourTime) == "6:" || String(hourTime) == "7:") && String(periodTime) == " AM" {
            
            timeLabel.textColor = UIColor(named: "Risky Color Code")
            timeScore = 75
            
        } else if ((String(hourTime) == "8:" || String(hourTime) == "9:" || String(hourTime) == "10:" || String(hourTime) == "11:") && String(periodTime) == " AM") || ((String(hourTime) == "12:" || String(hourTime) == "1:" || String(hourTime) == "2:") && String(periodTime) == " PM") {
            
            timeLabel.textColor = UIColor(named: "Safe Color Code")
            timeScore = 90
            
        }else if ((String(hourTime) == "3:" || String(hourTime) == "4:" || String(hourTime) == "5:" || String(hourTime) == "6:") && String(periodTime) == " PM") {
            timeLabel.textColor = UIColor(named: "Uncomfortable Color Code")
            timeScore = 85
        } else {
            timeLabel.textColor = UIColor(named: "Uncomfortable Color Code")
            timeScore = 80
        }
        
        //AVERAGE SCORE/ RIDE SCORE CALCULATION
        avgScore = (weatherScore + rainScore + tempScore + timeScore + windScore) / 5
        
        if avgScore >= 90 {
            topBanner.backgroundColor = UIColor(named: "Safe Color Code")
            rideScoreBanner.backgroundColor = UIColor(named: "Safe Color Code")
            creditBanner.backgroundColor = UIColor(named: "Safe Color Code")
            rideScoreResult.text = "Safe To Ride!"
        } else if avgScore >= 80 {
            topBanner.backgroundColor = UIColor(named: "Uncomfortable Color Code")
            rideScoreBanner.backgroundColor = UIColor(named: "Uncomfortable Color Code")
            creditBanner.backgroundColor = UIColor(named: "Uncomfortable Color Code")
            rideScoreResult.text = "Okay to Ride!"
        } else if avgScore >= 70 {
            topBanner.backgroundColor = UIColor(named: "Risky Color Code")
            rideScoreBanner.backgroundColor = UIColor(named: "Risky Color Code")
            creditBanner.backgroundColor = UIColor(named: "Risky Color Code")
            rideScoreResult.text = "Risky To Ride!"
        } else {
            topBanner.backgroundColor = UIColor(named: "Very Risky Color Code")
            rideScoreBanner.backgroundColor = UIColor(named: "Very Risky Color Code")
            creditBanner.backgroundColor = UIColor(named: "Very Risky Color Code")
            rideScoreResult.text = "Very Risky To Ride!"
        }
    }
    
}


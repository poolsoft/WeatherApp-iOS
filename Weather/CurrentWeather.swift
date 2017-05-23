//
//  CurrentWeather.swift
//  Weather
//
//  Created by JAY PATEL on 5/22/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class CurrentWeather {
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currTemp: Double!
    
    var cityName: String {
        if (_cityName == nil){
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if (_date == nil){
            _date = ""
        }
        let df = DateFormatter()
        df.dateStyle = .long
        df.timeStyle = .none
        _date = "Today, \(df.string(from: Date()))"
        return _date
    }
    
    var weatherType: String {
        if (_weatherType == nil){
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currTemp: Double {
        if (_currTemp == nil){
            _currTemp = 0.0
        }
        return _currTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        // Alamofire download
        print(currentWeatherURL)
        let currWeatherURL = URL(string: currentWeatherURL)!
        Alamofire.request(currWeatherURL).responseJSON { (response) in
            let result = response.result
            if let dict = result.value as? Dictionary<String, Any> {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }
                if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                    if let name = weather[0]["main"] as? String {
                        self._weatherType = name.capitalized
                    }
                }
                if let main = dict["main"] as? Dictionary<String, Any> {
                    if let temp = main["temp"] as? Double {
                        self._currTemp = temp - 273.15
                    }
                }
                print(self._cityName)
                print(self._weatherType)
                print(self._currTemp)
            }
            completed()
        }
    }
    
    func setCurrentLocation(locManager: CLLocationManager) {
//        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse){
            let loc = locManager.location
            lat = String(format: "%f", (loc?.coordinate.latitude)!)
            lon = String(format: "%f", (loc?.coordinate.longitude)!)
//        }
    }
}

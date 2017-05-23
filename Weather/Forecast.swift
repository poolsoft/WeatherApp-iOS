//
//  Forecast.swift
//  Weather
//
//  Created by JAY PATEL on 5/22/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class Forecast {
    private var _day: [String]! = [String]()
    private var _weatherType: [String]! = [String]()
    private var _highTemp: [String]! = [String]()
    private var _lowTemp: [String]! = [String]()
    
    var day: [String] {
        return _day
    }
    
    var weatherType: [String] {
        return _weatherType
    }
    
    var highTemp: [String] {
        return _highTemp
    }
    
    var lowTemp: [String] {
        return _lowTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        // Alamofire download
        print(forecastWeatherURL)
        let foreWeatherURL = URL(string: forecastWeatherURL)!
        Alamofire.request(foreWeatherURL).responseJSON { (response) in
            let result = response.result
            if let dict = result.value as? Dictionary<String, Any> {
                if let list = dict["list"] as? [Dictionary<String, Any>] {
                    var i = 0
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "cccc"
                    for obj in list {
                        self._day.append(dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: i, to: Date())!))
                        i += 1
                        if let temp = obj["temp"] as? Dictionary<String, Any> {
                            if let min = temp["min"] as? Double {
                                self._lowTemp.append(String.init(format: "%.f", min))
                            }
                            if let max = temp["max"] as? Double {
                                self._highTemp.append(String.init(format: "%.f", max))
                            }
                        }
                        if let weather = obj["weather"] as? [Dictionary<String, Any>] {
                            if let main = weather[0]["main"] as? String {
                                self._weatherType.append(main)
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
}

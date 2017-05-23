//
//  Constants.swift
//  Weather
//
//  Created by JAY PATEL on 5/22/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/"
private var _lat = "lat=-36"
var lat: String {
    get { return _lat }
    set { _lat = "lat=\(newValue)" }
}
private var _lon = "&lon=121"
var lon: String {
    get { return _lon }
    set { _lon = "&lon=\(newValue)" }
}
let appId = "&appid="

let API_KEY = "fb39a0002e1c926544acbab315985c1e"

var currentWeatherURL: String {
    return "\(BASE_URL)weather?\(lat)\(lon)\(appId)\(API_KEY)"
}

let cnt = "&cnt=10"

let cntInt = Int(cnt.substring(from: cnt.index(cnt.startIndex, offsetBy: 5)))!

var forecastWeatherURL: String {
    return "\(BASE_URL)forecast/daily?\(lat)\(lon)\(cnt)\(appId)\(API_KEY)"
}

typealias DownloadComplete = () -> ()

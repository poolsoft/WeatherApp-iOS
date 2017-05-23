//
//  ViewController.swift
//  Weather
//
//  Created by JAY PATEL on 5/22/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblWeatherType: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    var locManager: CLLocationManager!
    var currWeather: CurrentWeather!
    var forecast: Forecast!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        
        currWeather = CurrentWeather()
        forecast = Forecast()
        locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        locManager.delegate = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableCell
        let row = indexPath.row
        cell?.lblDay.text = forecast.day[row]
        cell?.lblLow.text = forecast.lowTemp[row]
        cell?.lblHigh.text = forecast.highTemp[row]
        cell?.lblType.text = forecast.weatherType[row]
        cell?.imgIcon.image = UIImage.init(named: forecast.weatherType[row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.day.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location authorization status changed")
        if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            currWeather.setCurrentLocation(locManager: manager)
        }
        currWeather.downloadWeatherDetails {
            self.lblDate.text = self.currWeather.date
            self.lblTemp.text = String(format: "%.f°",self.currWeather.currTemp)
            self.lblLocation.text = self.currWeather.cityName
            self.lblWeatherType.text = self.currWeather.weatherType
            self.imgIcon.image = UIImage.init(named: self.currWeather.weatherType)
        }
        forecast.downloadWeatherDetails {
            self.tblView.reloadData()
        }
    }
}


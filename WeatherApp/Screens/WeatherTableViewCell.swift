//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Alexander Krajči on 06/04/2022.
//

import UIKit



class WeatherTableViewCell: UITableViewCell {

    
    static var classString: String {
        String(describing: WeatherTableViewCell.self)
    }
    struct Weather {
        
        let day:String
        let weather:String
        let humidity:String
        let temperature:String
        
        init(weatherInfo: WeatherInfo){
            day = weatherInfo.day
            weather = weatherInfo.weather
            humidity = weatherInfo.humidity
            temperature = weatherInfo.temperature
        }
    }
    
    @IBOutlet weak var weatherDayLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var weatherHumidityLabel: UILabel!
    
    func setupView(weatherInfo:Weather) {
        weatherDayLabel.text = weatherInfo.day
        weatherHumidityLabel.text = weatherInfo.humidity
        weatherTemperatureLabel.text = weatherInfo.temperature
    }
}

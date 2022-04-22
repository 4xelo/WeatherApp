//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Alexander Krajči on 06/04/2022.
//

import UIKit



class WeatherTableViewCell: UITableViewCell {

    
    
    // MARK: - Outlets
    @IBOutlet weak var weatherDayLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var weatherHumidityLabel: UILabel!
    
    
    // MARK: - Static
    static var classString: String { String(describing: WeatherTableViewCell.self) }
}
    
extension WeatherTableViewCell {
    //MARK: - Public
    func setupCell(with day: DailyWeather) {
        //formatter ako singleton
        
        
        
        weatherDayLabel.text = DateFormatter.dayDateFormatter.string(from: day.date)
        weatherImageView.image = day.weather.first?.image?.withRenderingMode(.alwaysOriginal)
        weatherHumidityLabel.text = day.formattedPercipitation
        weatherTemperatureLabel.text = day.temp.temperatureWithCelsius
        
    }
    
}


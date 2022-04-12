//
//  Weather.swift
//  WeatherApp
//
//  Created by Alexander Krajči on 12/04/2022.
//

import Foundation
import UIKit

enum WeatherState {
    
    case sunny
    case cloudy
    case rainy
    case snowy
    case stormy
    var icon:UIImage? {
        
        switch self {
        case .sunny:
            return UIImage(systemName: "sun.max.fill")
        case .cloudy:
            return UIImage(systemName: "cloud.fill")
        case .rainy:
            return UIImage(systemName: "cloud.sun.rain.fill")
        case .snowy:
            return UIImage(systemName: "cloud.snow.fill")//na  bielej sa zobrazi bielo
        case .stormy:
            return UIImage(systemName: "cloud.bolt.rain.fill")
                
        
        }
    }
    
}

struct ForecastDay {
    
    let title: String
    let temperature: String
    let perception: Int
    let state: WeatherState
    
    var temperatureWithCelsius: String {"\(temperature)°C"}
    var perceptionWithPercentage: String {"\(perception)%"}
    
}


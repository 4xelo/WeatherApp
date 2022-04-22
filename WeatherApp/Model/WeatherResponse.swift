//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Alexander Krajči on 22/04/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import UIKit


// MARK: - Welcome
struct WeatherResponse: Decodable {

    let current: CurrentWeather
    let days: [DailyWeather]

    enum CodingKeys: String, CodingKey {
    case days = "daily"
    case current
    }
}

// MARK: - Current
struct CurrentWeather: Decodable {
    let date :Date
    let temp: Double
    let feelsLike: Double
    let weather: [Weather]

    var temperatureWithCelsius: String { "\(Int(temp))°C"}
    var formatedFeelsLikeWithCelsius: String { "\(Int(feelsLike))°C"}
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp
        case feelsLike = "feels_like"
        case weather
    }
}

// MARK: - Daily
struct DailyWeather: Decodable {
    let date: Date
    let temp: Temp
    let weather: [Weather]
    let precipitation: Double
    
    var formattedPercipitation: String { "\(Int(precipitation * 100))%"}
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case precipitation = "pop"
        case weather, temp
    }
    
}

// MARK: - Weather
struct Weather: Decodable {
   
    let description: String //tu je slovny popis pocasia
    let icon: String
    enum CodingKeys: String, CodingKey {
        case description = "main"
        case icon
    }
    
    var image: UIImage? {
        
        switch icon {
        case "03d":
            return UIImage(systemName: "cloud.fill")
        case "04d":
            return UIImage(systemName: "clouds.fill")
        case "11d":
            return UIImage(systemName: "cloud.bolt.fill")
        case "09d":
            return UIImage(systemName: "cloud.drizzle.fill")
        case "10d":
            return UIImage(systemName: "cloud.rain.fill")
        case "13d":
            return UIImage(systemName: "cloud.snow.fill")
        case "50d":
            return UIImage(systemName: "smoke.fill")
        case "01d":
            return UIImage(systemName: "sun.max.fill")
        case "02d":
            return UIImage(systemName: "cloud.sun.fill")
        default:
            return UIImage(systemName: "moon.circle.fill")
        }
    }
}

// MARK: - Temp
struct Temp: Decodable {
    let day: Double
    var temperatureWithCelsius: String { "\(Int(day))°C"}
    
}



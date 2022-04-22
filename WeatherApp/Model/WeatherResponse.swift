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

// MARK: - Welcome
struct WeatherResponse: Decodable {

    let current: CurrentWeather
    let daily: [DailyWeather]

}

// MARK: - Current
struct CurrentWeather: Decodable {
    let date :Date
    let temp: Double
    let feelsLike: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temp
        case feelsLike = "feels_like"
        case weather
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
}

// MARK: - Daily
struct DailyWeather: Decodable {
    let date: Date
    let temp: Temp
    let weather: [Weather]
    let precipitation: Double

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case precipitation = "pop"
        case weather, temp
    }
}


// MARK: - Temp
struct Temp: Decodable {
    let day: Double
    
}



//
//  RecordManager.swift
//  WeatherApp
//
//  Created by Alexander Krajči on 22/04/2022.
//

import Foundation
import CoreLocation
import Alamofire



struct RequestManager {
    
    static let shared = RequestManager()  //singleton
    
    func getWeatherData(for cordinates: CLLocationCoordinate2D, completion: @escaping (Result<WeatherResponse, AFError>) -> Void) {
        let request = WeatherRequest(
            latitude: "\(cordinates.latitude)",
            longitude: "\(cordinates.longitude)",
            exclude: "hourly,minutely,alerts",
            appId: "72a7d7f4e9e4fc221f1889c9aa29ce34",
            units: "metric")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        AF.request("https://api.openweathermap.org/data/2.5/onecall", method: .get, parameters: request)
            .validate()
            .responseDecodable(of: WeatherResponse.self, decoder: decoder) {completion($0.result)
               
            }
        
    }
    
}

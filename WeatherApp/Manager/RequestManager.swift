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
        
        
//        let parameters = ["lat": "\(cordinates.latitude)", //zoznam
//                          "lon": "\(cordinates.longitude)",
//                          "exclude": "hourly,minutely,alerts",
//                          "appid": "72a7d7f4e9e4fc221f1889c9aa29ce34",
//                          "units": "metric"]
        
        AF.request("https://api.openweathermap.org/data/2.5/onecall", method: .get, parameters: request)
            .validate()
            .responseDecodable(of: WeatherResponse.self) {completion($0.result)//generikum, bez toho aby som rozparsovaval Jason mi to spravi vnutri
               // switch response.result {
//                case .success(let weatherData):
//                    print(weatherData.current.temp)
//                case .failure(let error):
//                    print(error)
//                }
            }
        //takyto kod iba definuje co sa ma stat, na to aby sa spustil tak ho musim pridat do premennej alebo nad instanciou ho zavolam
//        URLSession.shared.dataTask(with: url){ data, response, error in
//
//            guard let data = data else {
//                return
//            }
//
//            do {
//            let decoder = JSONDecoder()
//            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
//            completion(weatherResponse, nil)
//            } catch let error {
//                print(error)
//            }
//        }.resume()//spusta response
    }
    
}

//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Alexander Krajči on 04/04/2022.
//

import UIKit


struct WeatherInfo {
    let day: String
    let weather: String
    let humidity: String
    let temperature: String
}

class WeatherDetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var TemperatureLabel: UILabel!
    @IBOutlet weak var WeatherLabel: UILabel!
    @IBOutlet weak var FeelsLikeLabel: UILabel!
    
    
    var weatherArray: [WeatherInfo] {
           [WeatherInfo(day: "Monday", weather: "Rain", humidity: "80%", temperature: "16°C"),
            WeatherInfo(day: "Tuesday", weather: "Sun", humidity: "40%", temperature: "25°C"),
            WeatherInfo(day: "Wednesday", weather: "Rain", humidity: "70%", temperature: "19°C"),
            WeatherInfo(day: "Thursday", weather: "Rain", humidity: "90%", temperature: "20°C"),
            WeatherInfo(day: "Friday", weather: "Rain", humidity: "65%", temperature: "18°C"),
            WeatherInfo(day: "Saturday", weather: "Sun", humidity: "30%", temperature: "27°C"),
            WeatherInfo(day: "Sunday", weather: "Sun", humidity: "35%", temperature: "26°C")]
       }
    
    
    var weatherDays: [String] {["Monday" , "Tuesday" , "Wednesday" , "Thursday" , "Friday" , "Saturday" , "Sunday"]}
    
    override func viewDidLoad() {
        //TableView.tableHeaderView = nil
        TableView.dataSource = self
        
        TableView.register(UINib(nibName: WeatherTableViewCell.classString, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.classString)
        super.viewDidLoad()
        
    }
}
extension WeatherDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let weatherCell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.classString, for: indexPath)
                as? WeatherTableViewCell else {
                    
                    return UITableViewCell()
                }
        let weather = WeatherTableViewCell.Weather(weatherInfo: weatherArray[indexPath.row])
        weatherCell.setupView(weatherInfo: weather)
        return weatherCell
        
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int)->String? {
        return "Header in \(section).section"
        
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Footer in \(section).section"
    }
}
extension WeatherDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Alexander Krajči on 04/04/2022.
//

import UIKit


class WeatherDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var TemperatureLabel: UILabel!
    @IBOutlet weak var WeatherLabel: UILabel!
    @IBOutlet weak var FeelsLikeLabel: UILabel!
    
    //MARK: - Variables
    var days: [ForecastDay] {
        [ForecastDay(title: "Monday", temperature: "16", perception: 80, state: WeatherState.rainy),
            ForecastDay(title: "Tuesday", temperature: "25", perception: 40, state: WeatherState.sunny),
            ForecastDay(title: "Wednesday", temperature: "27", perception: 20, state: WeatherState.sunny),
            ForecastDay(title: "Thursday", temperature: "17", perception: 90, state: WeatherState.rainy),
            ForecastDay(title: "Friday", temperature: "21", perception: 70, state: WeatherState.cloudy),
            ForecastDay(title: "Saturday", temperature: "24", perception: 10, state: WeatherState.sunny),
            ForecastDay(title: "Sunday", temperature: "26", perception: 10, state: WeatherState.sunny)]
       }
    
    
    var weatherDays: [String] {["Monday" , "Tuesday" , "Wednesday" , "Thursday" , "Friday" , "Saturday" , "Sunday"]}
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        //TableView.tableHeaderView = nil
        TableView.dataSource = self
        
        TableView.register(UINib(nibName: WeatherTableViewCell.classString, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.classString)
        super.viewDidLoad()
        
    }
}

//MARK: - Table View Data Source
extension WeatherDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let weatherCell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.classString, for: indexPath)
                as? WeatherTableViewCell else {
                    
                    return UITableViewCell()
                }
        weatherCell.setupCell(with: days[indexPath.row])
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

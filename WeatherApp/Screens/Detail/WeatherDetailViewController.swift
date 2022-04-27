//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Alexander Krajči on 04/04/2022.
//

import UIKit
import CoreLocation

class WeatherDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var TemperatureLabel: UILabel!
    @IBOutlet weak var WeatherLabel: UILabel!
    @IBOutlet weak var FeelsLikeLabel: UILabel!
    
    //MARK: - Variables
        
    var place: Place?
    
    var refreshControl = UIRefreshControl()
    var days = [DailyWeather]()
    
 

    
    @IBAction func Search(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SearchViewController", bundle: nil)
        if let navigationController = storyboard.instantiateInitialViewController()  {
            present(navigationController, animated: true)
        }
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        //TableView.tableHeaderView = nil
        
        super.viewDidLoad()
        TableView.dataSource = self
        LocationLabel.text = place?.city
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, YYYY"
        DateLabel.text = formatter.string(from: Date())
        
        LocationManager.shared.getLocation { [weak self] location, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Tu je chyba")
            } else if let location = location {
                RequestManager.shared.getWeatherData(for: location.coordinates) {[weak self] response in
                    switch response {
                    case .success(let weatherData):
                        self?.setupView(with: weatherData.current)
                        self?.days = weatherData.days
                        self?.TableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }//posunutie o vrstvu, kontroler ziskal data, potrebuje uz iba konkretny objekt
                }
                
                self.LocationLabel.text = location.city
            }
        }
        
        TableView.register(UINib(nibName: WeatherTableViewCell.classString, bundle: nil),
                           forCellReuseIdentifier: WeatherTableViewCell.classString)
        
    }
    
    func setupView(with currentWeather: CurrentWeather) {
       
        TemperatureLabel.text = currentWeather.temperatureWithCelsius
        FeelsLikeLabel.text = "Feels like \(currentWeather.formatedFeelsLikeWithCelsius)"
        WeatherLabel.text = currentWeather.weather.first?.description
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
}

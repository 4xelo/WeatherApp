import UIKit
import CoreLocation

enum State {
    case loading
    case error (String)
    case success(WeatherResponse)
}

class WeatherDetailViewController: UIViewController, UITableViewDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var TemperatureLabel: UILabel!
    @IBOutlet weak var WeatherLabel: UILabel!
    @IBOutlet weak var FeelsLikeLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
   
   
    //MARK: - Variables
    
    var place: Place?
    var location: CurrentLocation?
    var refreshControl = UIRefreshControl()
    var days = [DailyWeather]()
    var state: State = .loading {
        didSet {reloadState()}
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        updateLocation()
//        LocationManager.shared.onAuthorizationChange { authorized in
//            if authorized != nil {
//                self.updateLocation()
//            } else {
//            }
//        }
//        if LocationManager.shared.denied {
//            presentAlert()
//        } else {
//            updateLocation()
//        }
        TableView.dataSource = self
        TableView.delegate = self
    }
}
//MARK: - Actions

extension WeatherDetailViewController{
    @IBAction func reload(_ sender: Any) {
        loadData()
    }
    @IBAction func Search(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SearchViewController", bundle: nil)
        if let navigationController = storyboard.instantiateInitialViewController()  {
            present(navigationController, animated: true)
        }
    }
}

// MARK: - Setup
private extension WeatherDetailViewController {
    func setupTableView() {
        TableView.isHidden = true;
        TableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        TableView.register(
            UINib(
                nibName: WeatherTableViewCell.classString,
                bundle: nil),
            forCellReuseIdentifier: WeatherTableViewCell.classString)
    }
    func setupView(with currentWeather: CurrentWeather) {
        LocationLabel.text = place?.city
        DateLabel.text = DateFormatter.mediumDateFormatter.string(from: currentWeather.date)
        TemperatureLabel.text = currentWeather.temperatureWithCelsius
        FeelsLikeLabel.text = currentWeather.formatedFeelsLikeWithCelsius
        WeatherLabel.text = currentWeather.weather.first?.description
    }
    func reloadState() {
            switch state {
            case .loading:
                activityIndicator.startAnimating()
                TableView.isHidden = true
                emptyView.isHidden = true
                
            case .error(let message):
                refreshControl.endRefreshing()
                activityIndicator.stopAnimating()
                TableView.isHidden = true
                errorMessageLabel.text = message
                
            case .success(let weatherData):
                refreshControl.endRefreshing()
                activityIndicator.stopAnimating()
                TableView.isHidden = false
                emptyView.isHidden = true
                setupView(with: weatherData.current)
                days = weatherData.days
                TableView.reloadSections(IndexSet(integer: 0), with: .fade)
            }
        }
    func presentAlert() {
        let alertController = UIAlertController(title: "Toto je title", message: "Toto je message", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {action in
            print("Ok")
        }
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { action in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(settingsUrl) else {
                      return
                  }
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
        alertController.addAction(okAction)
        alertController.addAction(settingsAction)
        present(alertController, animated: true)
            
    }
}

// MARK: - Request & Location
private extension WeatherDetailViewController {
   
    @objc func loadData() {
        guard let location = location else {
            return
        }
        
        state = .loading
        
        RequestManager.shared.getWeatherData(for: location.coordinates) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let weatherData):
                self.state = .success(weatherData)
            case .failure(let error):
                self.state = .error(error.localizedDescription)
            }
        }
    }
    
    func updateLocation() {
            LocationManager.shared.getLocation { [weak self] location, error in
                guard let self = self else { return }
                
                if let error = error {
                    self.state = .error(error.localizedDescription)
                } else if let location = location {
                    self.location = location
                    self.loadData()
                    }
                }
        }
}
extension WeatherDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let weatherCell = tableView.dequeueReusableCell(
            withIdentifier: WeatherTableViewCell.classString,
            for: indexPath) as? WeatherTableViewCell
        else {
            return UITableViewCell()
        }
        
        weatherCell.setupCell(with: days[indexPath.row])
        return weatherCell
    }
}

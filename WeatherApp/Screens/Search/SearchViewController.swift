//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Alexander Krajči on 18/04/2022.
//

import UIKit

class SearchViewController: UIViewController {

    
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Actions
    
    @IBAction func close(_ sender: Any) {
        
        dismiss(animated: true)
    }
    //MARK: - Variables
    private let searchController = UISearchController(searchResultsController: nil)
    private var places = [Place]()
    private let searchManager = SearchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchController()
    }
    func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.searchBar.delegate = self
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchManager.getLocalSearchResult(from: searchText) {places in
            self.places = places
            self.tableView.reloadData()
        }
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchCell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        let place = places[indexPath.row]
        searchCell.textLabel?.text = place.city
        searchCell.detailTextLabel?.text = place.country
    
        return searchCell
    }
}

extension SearchViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        presentWeatherDetail(with: place)
    }
    
    func presentWeatherDetail(with place: Place) {
        let storyboard = UIStoryboard(name: "WeatherDetailViewController", bundle: nil)
        
        
        if let weatherViewController = storyboard.instantiateViewController(withIdentifier: "idecko")as? WeatherDetailViewController  {
            weatherViewController.place = place
            navigationController?.pushViewController(weatherViewController, animated: true)
        }
    }
}

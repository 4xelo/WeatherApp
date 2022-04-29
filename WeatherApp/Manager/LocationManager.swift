//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Alexander Krajči on 12/04/2022.
//

import Foundation
import CoreLocation



struct CurrentLocation {
    
    let city: String
    let coordinates: CLLocationCoordinate2D
    
}

typealias CityCompletionHandler = ((CurrentLocation?, Error?) -> Void)
typealias AuthorizationHandler  = ((Bool?) -> Void)


class LocationManager : CLLocationManager{
    
    static let shared = LocationManager()
    private var geocoder = CLGeocoder()
    
    
    var completion: CityCompletionHandler?
    var denied: Bool {
        LocationManager.authorizationStatus() == .denied
    }
    var authorizationCompletion: AuthorizationHandler?
    
    
    func getLocation(completion: CityCompletionHandler?){
        self.completion = completion
        requestWhenInUseAuthorization()
        startUpdatingLocation()
        delegate = self
    }
    
    func onAuthorizationChange(completion: @escaping AuthorizationHandler) {
        authorizationCompletion = completion
        
    }
    func getCoordinates(for city: String, completion: @escaping (CLLocationCoordinate2D) -> Void) {
        geocoder.geocodeAddressString(city) { placemarks, error in
            if let coordinates = placemarks?.first?.location?.coordinate {
                completion(coordinates)
            }
        }
    }
}
//MARK: - Location Manager Delegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        geocoder.reverseGeocodeLocation(location) {[weak self] placemarks, error in
            guard let self = self else { return}
            
            guard let placemark = placemarks?.first, let city = placemark.locality, error == nil else {
                if let completion = self.completion {
                completion(nil, error)
                }
                return
            }
            let currentLocation = CurrentLocation(city: city, coordinates: location.coordinate)
                self.completion?(currentLocation, nil)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied :
            authorizationCompletion?(false)
        case .authorizedWhenInUse, .authorizedAlways:
            authorizationCompletion?(true)
        case .restricted:
            print("Restricted")
        case .notDetermined:
            print("Not determined")
        @unknown default:
            print("sth else")
        }
    }
}

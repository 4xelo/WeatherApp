//
//  DateFormatter.swift
//  WeatherApp
//
//  Created by Alexander Krajči on 22/04/2022.
//

import Foundation

extension DateFormatter {
    
    static let dayDateFormatter: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter
    }()
    static let mediumDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }()
}

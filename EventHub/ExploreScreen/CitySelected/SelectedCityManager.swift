//
//  SelectedCityManager.swift
//  EventHub
//
//  Created by Валентина Попова on 24.11.2024.
//

import Foundation

struct SelectedCityManager {
    private static let selectedCityKey = "selectedCityKey"
    
    static func saveSelectedCity(_ city: City) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(city) {
            UserDefaults.standard.set(encoded, forKey: selectedCityKey)
        }
    }
    
    static func getSelectedCity() -> City? {
        if let savedCity = UserDefaults.standard.object(forKey: selectedCityKey) as? Data {
            let decoder = JSONDecoder()
            return try? decoder.decode(City.self, from: savedCity)
        }
        return nil
    }
}

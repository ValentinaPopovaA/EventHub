//
//  CityService.swift
//  EventHub
//
//  Created by Валентина Попова on 24.11.2024.
//

import Foundation

final class CityService {
    static let shared = CityService()
    
    private let networkService = NetworkService()
    
    func fetchCities(completion: @escaping (Result<[City], Error>) -> Void) {
        let request = CitiesRequest()
        networkService.request(request, completion: completion)
    }
}

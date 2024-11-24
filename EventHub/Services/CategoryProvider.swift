//
//  CategoryProvider.swift
//  EventHub
//
//  Created by Валентина Попова on 24.11.2024.
//

import UIKit

final class CategoryProvider {
    static let shared = CategoryProvider()
    
    private let networkService = NetworkService()

    private let categoryColors: [UIColor] = [
        .redAccent,
        .orangeAccent,
        .greenAccent,
        .darkCyanAccent,
        .purpleAccent,
        .pinkAccent,
        .yellowAccent
    ]

    func fetchCategoriesFromAPI(completion: @escaping (Result<[Category], Error>) -> Void) {
        let request = EventCategoryRequest()
        networkService.request(request) { result in
            switch result {
            case .success(let apiCategories):
                // Преобразуем данные API в категории с цветами
                let categories = apiCategories.enumerated().map { index, apiCategory in
                    let color = self.categoryColors[index % self.categoryColors.count]
                    return Category(name: apiCategory.name, color: color)
                }
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

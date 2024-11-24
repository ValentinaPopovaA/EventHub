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
    
    private let sfSymbols: [String] = [
        "briefcase.fill", "film.fill", "music.note.list", "book.fill",
        "gamecontroller.fill", "paintpalette.fill", "scissors", "sparkles",
        "gift.fill", "teddybear.fill", "square.grid.2x2.fill", "party.popper",
        "camera.fill", "magnifyingglass", "figure.walk", "cart.fill",
        "hands.sparkles.fill", "tag.fill", "theatermasks.fill", "bus.fill",
        "building.columns.fill"
    ]
    
    private let nameShortcuts: [String: String] = [
        "События для бизнеса":  "Бизнес",
        "Ярмарки (Развлечения, Ярмарки)": "Ярмарки",
        "Шопинг (Магазины)": "Шопинг",
    ]
    
    func fetchCategoriesFromAPI(completion: @escaping (Result<[Category], Error>) -> Void) {
        let request = EventCategoryRequest()
        networkService.request(request) { result in
            switch result {
            case .success(let apiCategories):
                let categories = apiCategories.enumerated().map { index, apiCategory in
                    let color = self.categoryColors[index % self.categoryColors.count]
                    let sfSymbol = self.sfSymbols[index % self.sfSymbols.count]
                    
                    let shortenedName = self.nameShortcuts[apiCategory.name] ?? apiCategory.name
                    
                    return Category(name: shortenedName, color: color, sfSymbol: sfSymbol)
                }
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

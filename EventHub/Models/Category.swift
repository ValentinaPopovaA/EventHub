//
//  Category.swift
//  EventHub
//
//  Created by Валентина Попова on 24.11.2024.
//

import UIKit

struct Category {
    let name: String
    let color: UIColor
}

final class CategoryProvider {
    static func fetchCategories() -> [Category] {
        return [
            Category(name: "Business", color: .redAccent),
            Category(name: "Cinema", color: .orangeAccent),
            Category(name: "Food", color: .greenAccent),
            Category(name: "Art", color: .redAccent),
            Category(name: "Libraries", color: .orangeAccent),
            Category(name: "Libraries", color: .greenAccent),
        ]
    }
}
//private let categories: [Category] = [
//    Category(name: "Sports", color: .redAccent),
//    Category(name: "Music", color: .orangeAccent),
//    Category(name: "Food", color: .greenAccent)
//]

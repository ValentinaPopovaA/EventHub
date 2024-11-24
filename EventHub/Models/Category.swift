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

struct EventCategory: Decodable {
    let id: Int
    let slug: String
    let name: String
}

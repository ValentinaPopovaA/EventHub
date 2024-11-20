//
//  EventImage.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

struct EventImage: Codable {
    let image: String                // URL изображения
    let source: ImageSource?         // Источник изображения
}

struct ImageSource: Codable {
    let name: String                 // Название источника
    let link: String?                // Ссылка на источник
}


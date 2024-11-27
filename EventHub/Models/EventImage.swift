//
//  EventImage.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

struct EventImage: Decodable {
    let image: String                // URL изображения
    let source: ImageSource?         // Источник изображения
}

struct ImageSource: Decodable {
    let link: String?  
    let name: String
}


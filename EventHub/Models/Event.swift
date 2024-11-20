//
//  EventsError.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//

import Foundation

struct EventsResponse: Codable {
    let results: [Event]
}

struct Event: Codable {
    let id: Int                      // ID события
    let publicationDate: Int?        // Дата публикации (в Unix)
    let title: String                // Название события
    let slug: String                 // Уникальный идентификатор события
    let place: Place?                // Место проведения
    let description: String?         // Краткое описание (в формате HTML)
    let bodyText: String?            // Полный текст (в формате HTML)
    let images: [EventImage]?        // Изображения события
    let siteURL: String?             // Ссылка на страницу события
    let commentsCount: Int?          // Количество комментариев
    let dates: [EventDate]?
}

//struct EventResponse: Decodable {
//    let results: [Event]
//}
//
//struct Event: Codable, Equatable {
//    let id: Int
//    let title: String
//    let description: String?
//    let place: Place?
//    let categories: [String]
//    let dates: [EventDate]
//    let organizer: String?
//    let tags: [String]?
//    let images: [EventImage]
//}

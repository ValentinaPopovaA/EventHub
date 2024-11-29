//
//  EventsError.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//

import Foundation

struct EventsResponse: Decodable {
    let results: [Event]
}

struct Event: Decodable {
    let id: Int                      // ID события
    let publicationDate: Int?        // Дата публикации (в Unix)
    let title: String                // Название события
    let slug: String?                 // Уникальный идентификатор события
    var place: Place?                // Место проведения
    let categories: [String]?
    let description: String?         // Краткое описание (в формате HTML)
    let bodyText: String?            // Полный текст (в формате HTML)
    let tags: [String]?
    let images: [EventImage]?        // Изображения события
    let siteURL: String?             // Ссылка на страницу события
    let commentsCount: Int?          // Количество комментариев
    var dates: [EventDate]?
    let participants: [Participant]?
    let first_image: EventImage?
    let thumbnails: [String: String]?
    let daterange: EventDate?
    let favoritesCount: Int?
    
    var formattedTitle: String {
        return title.prefix(1).uppercased() + title.dropFirst().lowercased()
    }
}

struct Participant: Decodable {
    let agent: Agent
}

struct Agent: Decodable {
    let id: Int
    let title: String
    let slug: String
    let images: [String]
}

extension Event {
    var nextDate: EventDate? {
        if let dates = dates, !dates.isEmpty {
            return dates.min(by: { ($0.start ?? 0) < ($1.start ?? 0) })
        } else {
            return daterange
        }
    }
    
    var previousDate: EventDate? {
        if let dates = dates, !dates.isEmpty {
            return dates.max(by: { ($0.start ?? 0) < ($1.start ?? 0) })
        } else {
            return daterange
        }
    }
}

enum Segment {
    case upcoming
    case past
}

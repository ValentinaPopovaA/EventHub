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
    let place: Place?                // Место проведения
    let categories: [String]?
    let description: String?         // Краткое описание (в формате HTML)
    let bodyText: String?            // Полный текст (в формате HTML)
    let tags: [String]?
    let images: [EventImage]?        // Изображения события
    let siteURL: String?             // Ссылка на страницу события
    let commentsCount: Int?          // Количество комментариев
    let dates: [EventDate]?
    let participants: [Participant]?
    
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
        return dates?
            .filter { ($0.start ?? 0) > Int(Date().timeIntervalSince1970) }
            .min(by: { ($0.start ?? 0) < ($1.start ?? 0) })
    }
    
    var previousDate: EventDate? {
        return dates?
            .filter { ($0.start ?? 0) <= Int(Date().timeIntervalSince1970) }
            .max(by: { ($0.start ?? 0) < ($1.start ?? 0) })
    }
}

enum Segment {
    case upcoming
    case past
}

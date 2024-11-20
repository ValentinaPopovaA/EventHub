//
//  EventsError.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//

import Foundation

struct EventResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Event]
}

struct Event: Codable, Equatable {
    let id: Int
    let title: String
    let description: String?
    let place: Place?
    let categories: [String]
    let dates: [EventDate]
    let organizer: String?
    let tags: [String]
    let images: [EventImage]
}

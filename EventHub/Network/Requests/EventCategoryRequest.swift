//
//  CategoryRequest.swift
//  EventHub
//
//  Created by Валентина Попова on 24.11.2024.
//

import Foundation

struct EventCategoryRequest: DataRequest {
    typealias Response = [EventCategory]

    var url: String {
        "https://kudago.com/public-api/v1.4/event-categories/?lang=&order_by=&fields="
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String] {
        [:]
    }

    var queryItems: [String: String] {
        [:]
    }

    func decode(_ data: Data) throws -> [EventCategory] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([EventCategory].self, from: data)
    }
}

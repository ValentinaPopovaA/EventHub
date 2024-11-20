//
//  EventsNext7DaysRequest.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

struct EventsNext7DaysRequest: DataRequest {
    var headers: [String : String]
    var citySlug: String

    var queryItems: [String: String] {
        let now = Int(Date().timeIntervalSince1970)
        let nextWeek = now + (7 * 24 * 60 * 60)
        return [
            "location": citySlug,
            "actual_since": "\(now)",
            "actual_until": "\(nextWeek)",
            "page_size": "10"
        ]
    }

    var url: String {
        "https://kudago.com/public-api/v1.4/events"
    }

    var method: HTTPMethod { .get }

    func decode(_ data: Data) throws -> EventResponse {
        let decoder = JSONDecoder()
        return try decoder.decode(EventResponse.self, from: data)
    }
}

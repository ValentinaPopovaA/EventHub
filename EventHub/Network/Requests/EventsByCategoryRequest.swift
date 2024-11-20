//
//  EventsByCategoryRequest.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

struct EventsByCategoryRequest: DataRequest {
    var headers: [String : String]
    var category: String
    var citySlug: String

    var queryItems: [String: String] {
        [
            "categories": category,
            "location": citySlug,
            "actual_since": "\(Int(Date().timeIntervalSince1970))",
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

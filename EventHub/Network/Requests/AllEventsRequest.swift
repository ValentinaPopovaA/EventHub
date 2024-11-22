//
//  AllEventsRequest.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

struct AllEventsRequest: DataRequest {
    typealias Response = [Event]
    
    var headers: [String : String]
    var citySlug: String
    var queryItems: [String: String] {
        [
            "location": citySlug,
            "page_size": "25"
        ]
    }

    var url: String {
        "https://kudago.com/public-api/v1.4/events"
    }

    var method: HTTPMethod { .get }

    func decode(_ data: Data) throws -> [Event] {
        let decoder = JSONDecoder()
        return try decoder.decode([Event].self, from: data)
    }
}

//
//  EventsLast7DaysRequest.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

struct EventsLast7DaysRequest: DataRequest {
    typealias Response = [Event]
    
    var headers: [String : String]
    var citySlug: String
    var queryItems: [String: String] {
        let now = Int(Date().timeIntervalSince1970)
        let lastWeek = now - (7 * 24 * 60 * 60)
        return [
            "location": citySlug,
            "actual_since": "\(lastWeek)",
            "actual_until": "\(now)",
            "page_size": "10"
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

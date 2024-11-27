//
//  SearchEventsRequest.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

struct SearchEventsRequest: DataRequest {
    typealias Response = [Event]
    
    var headers: [String : String]
    var query: String
    var citySlug: String
    
    var queryItems: [String: String] {
        [
            "q": query,
            "location": citySlug,
            "page_size": "10",
            "ctype": "event"
        ]
    }
    
    var url: String {
        "https://kudago.com/public-api/v1.4/search/"
    }
    
    var method: HTTPMethod { .get }
    
    func decode(_ data: Data) throws -> [Event] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(EventsResponse.self, from: data)
        return response.results
    }
}

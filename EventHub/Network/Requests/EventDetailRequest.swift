//
//  EventDetailRequest.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

struct EventDetailsRequest: DataRequest {
    typealias Response = Event

    let eventID: Int

    var url: String {
        "https://kudago.com/public-api/v1.4/events/\(eventID)/?lang=&fields=&expand="
    }

    var headers: [String: String] {
        [:]
    }

    var queryItems: [String: String] {
        [:]
    }

    var method: HTTPMethod {
        .get
    }

    func decode(_ data: Data) throws -> Event {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Event.self, from: data)
    }

}

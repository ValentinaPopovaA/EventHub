//
//  PlaceDetailsRequest.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

struct PlaceDetailsRequest: DataRequest {
    typealias Response = Place

    let placeID: Int

    var url: String {
        "https://kudago.com/public-api/v1.4/places/\(placeID)/?lang=&fields=&expand="
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

    func decode(_ data: Data) throws -> Place {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Place.self, from: data)
    }
}

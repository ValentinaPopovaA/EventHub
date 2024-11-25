//
//  CitiesRequest.swift
//  EventHub
//
//  Created by Валентина Попова on 24.11.2024.
//

import Foundation

struct CitiesRequest: DataRequest {
    typealias Response = [City]
    
    var url: String {
        "https://kudago.com/public-api/v1.4/locations/?lang=&fields=&order_by="
    }
    
    var method: HTTPMethod { .get }
    var headers: [String: String] { [:] }
    var queryItems: [String: String] { [:] }
    
    func decode(_ data: Data) throws -> [City] {
        let decoder = JSONDecoder()
        return try decoder.decode([City].self, from: data)
    }
}

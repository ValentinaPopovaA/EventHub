//
//  EventsNext7DaysRequest.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

struct EventsRequest: DataRequest {
    typealias Response = EventsResponse

    let actualSince: Int
    let actualUntil: Int

    var url: String {
        "https://kudago.com/public-api/v1.4/events/"
    }

    var headers: [String: String] {
        [:]
    }

    var queryItems: [String: String] {
        [
            "lang": "ru",
            "actual_since": "\(actualSince)",
            "actual_until": "\(actualUntil)",
            "fields": "id,dates,title,place,images,slug"
        ]
    }

    var method: HTTPMethod {
        .get
    }

    func decode(_ data: Data) throws -> EventsResponse {
        // Проверяем структуру данных перед декодированием
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            print(jsonObject) // Отладочный вывод для проверки структуры JSON
        } catch {
            print("Ошибка декодирования JSON: \(error)")
        }
        
        // Реальное декодирование в структуру
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(EventsResponse.self, from: data)
    }
}

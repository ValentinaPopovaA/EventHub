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
    let page: Int
    let pageSize: Int

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
            "fields": "id,dates,title,place,images,slug",
            "page": "\(page)",
            "page_size": "\(pageSize)"
        ]
    }

    var method: HTTPMethod {
        .get
    }

    func decode(_ data: Data) throws -> EventsResponse {
        // Отладочный вывод
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            print("Ответ API: \(jsonObject)") // Для проверки структуры JSON
        } catch {
            print("Ошибка декодирования JSON: \(error)")
        }

        // Декодирование
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(EventsResponse.self, from: data)
    }
}

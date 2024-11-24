//
//  CategoryRequest.swift
//  EventHub
//
//  Created by Валентина Попова on 24.11.2024.
//

//import Foundation
//
//struct CategoryRequest: DataRequest {
//    typealias Response = [Category]
//
//    var url: String {
//        "https://kudago.com/public-api/v1.2/event-categories/"
//    }
//
//    var method: HTTPMethod {
//        .get
//    }
//
//    var headers: [String: String] {
//        [:]
//    }
//
//    var queryItems: [String: String] {
//        [
//            "lang": "ru",
//            "fields": "slug"
//        ]
//    }
//
////    func decode(_ data: Data) throws -> [Category] {
////        let decoder = JSONDecoder()
////        decoder.keyDecodingStrategy = .convertFromSnakeCase
////        return try decoder.decode([Category].self, from: data)
////    }
//}

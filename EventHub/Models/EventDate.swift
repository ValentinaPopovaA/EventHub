//
//  EventDate.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

struct EventDate: Decodable {
    let start: Int
    let end: Int?
    
    var startDate: Date {
        Date(timeIntervalSince1970: TimeInterval(start))
    }
    
    var endDate: Date? {
        guard let end = end else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(end))
    }
    
    var dayOfWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: startDate)
    }
}

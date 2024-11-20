//
//  DateFormatter+Ext.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

import Foundation

extension Int {
    func formattedDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, yyyy" // Пример: Пятница, 15 ноября 2024
        formatter.locale = Locale(identifier: "en_US") // "ru_RU"
        return formatter.string(from: date)
    }

    func formattedTimeWithWeekday() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, HH:mm" // Пример: Пятница, 19:30
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }

    func formattedTime() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // Пример: 19:30
        return formatter.string(from: date)
    }
}

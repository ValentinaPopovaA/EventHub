//
//  Place.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import Foundation

struct Place: Decodable {
    let id: Int?
    let title: String?
    let address: String?
    let location: String?
    
    func cityName(for slug: String) -> String {
        let supportedCities: [City] = [
            City(slug: "spb", name: "Санкт-Петербург"),
            City(slug: "msk", name: "Москва"),
            City(slug: "nsk", name: "Новосибирск"),
            City(slug: "ekb", name: "Екатеринбург"),
            City(slug: "nnv", name: "Нижний Новгород"),
            City(slug: "kzn", name: "Казань"),
            City(slug: "vbg", name: "Выборг"),
            City(slug: "smr", name: "Самара"),
            City(slug: "krd", name: "Краснодар"),
            City(slug: "sochi", name: "Сочи"),
            City(slug: "ufa", name: "Уфа"),
            City(slug: "krasnoyarsk", name: "Красноярск"),
            City(slug: "kev", name: "Киев"),
            City(slug: "new-york", name: "Нью-Йорк")
        ]
        
        return supportedCities.first(where: { $0.slug == slug })?.name ?? "Неизвестный город"
    }
}

struct location: Decodable {
    let slug: String?
}

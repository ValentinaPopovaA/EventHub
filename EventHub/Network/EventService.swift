//
//  EventService.swift
//  EventHub
//
//  Created by Валентина Попова on 22.11.2024.
//

import Foundation

final class EventService {
    private let networkService = NetworkService()

    func fetchEventDetails(eventID: Int, completion: @escaping (Result<Event, Error>) -> Void) {
        let request = EventDetailsRequest(eventID: eventID)
        networkService.request(request, completion: completion)
    }

    func fetchPlaceDetails(placeID: Int, completion: @escaping (Result<Place, Error>) -> Void) {
        let request = PlaceDetailsRequest(placeID: placeID)
        networkService.request(request, completion: completion)
    }
}

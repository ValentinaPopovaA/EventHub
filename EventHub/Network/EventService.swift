//
//  EventService.swift
//  EventHub
//
//  Created by Валентина Попова on 22.11.2024.
//

import Foundation

final class EventService {
    private let networkService = NetworkService()
    
    func fetchEvents(
        actualSince: Int,
        actualUntil: Int,
        sortAscending: Bool = true,
        page: Int = 1,
        pageSize: Int = 150,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        let request = EventsRequest(
            actualSince: actualSince,
            actualUntil: actualUntil,
            page: page,
            pageSize: pageSize
        )
        
        networkService.request(request) { (result: Result<EventsResponse, Error>) in
            completion(result.map { response in
                response.results
                    .filter { event in
                        guard let validDates = event.dates?.compactMap({ $0.start }).filter({ $0 >= actualSince && $0 <= actualUntil }) else {
                            return false
                        }
                        return !validDates.isEmpty
                    }
                    .map { event in
                        var mutableEvent = event
                        mutableEvent.dates = event.dates?.filter { $0.start ?? 0 >= actualSince && $0.start ?? 0 <= actualUntil }
                        return mutableEvent
                    }
                    .sorted { event1, event2 in
                        if sortAscending {
                            let date1 = event1.dates?.compactMap({ $0.start }).min() ?? 0
                            let date2 = event2.dates?.compactMap({ $0.start }).min() ?? 0
                            return date1 < date2
                        } else {
                            let date1 = event1.dates?.compactMap({ $0.start }).max() ?? 0
                            let date2 = event2.dates?.compactMap({ $0.start }).max() ?? 0
                            return date1 > date2
                        }
                    }
            })
        }
    }

    func fetchEventDetails(eventID: Int, completion: @escaping (Result<Event, Error>) -> Void) {
        let request = EventDetailsRequest(eventID: eventID)
        networkService.request(request, completion: completion)
    }

    func fetchPlaceDetails(placeID: Int, completion: @escaping (Result<Place, Error>) -> Void) {
        let request = PlaceDetailsRequest(placeID: placeID)
        networkService.request(request, completion: completion)
    }
}

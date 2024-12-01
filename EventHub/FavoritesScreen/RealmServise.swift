//
//  RealmServise.swift
//  EventHub
//
//  Created by apple on 11/30/24.
//

import RealmSwift

class FavoritesService {
    
    private let realm = try! Realm()
    
    // Добавление события в избранное
    func addToFavorites(event: Event) {
        let favoriteEvent = FavoriteEvent()
        favoriteEvent.id = event.id
        favoriteEvent.title = event.title
        favoriteEvent.publicationDate = event.publicationDate
        favoriteEvent.descriptionText = event.description
        favoriteEvent.imageURL = event.first_image?.image
        favoriteEvent.location = event.place?.title
        
        do {
            try! realm.write {
                realm.add(favoriteEvent, update: .modified)
                print("Event added to favorites: \(favoriteEvent.title)")
            }
        } catch {
            print("Error adding event to favorites: \(error)")
        }
    }
    // Удаление события из избранного
    func removeFromFavorites(eventID: Int) {
        // Найти и удалить объект в базе данных
        if let favoriteEvent = realm.object(ofType: FavoriteEvent.self, forPrimaryKey: eventID) {
            try! realm.write {
                realm.delete(favoriteEvent)
            }
        }
    }
    
    // Проверка, находится ли событие в избранном
    func isFavorite(eventID: Int) -> Bool {
        return realm.object(ofType: FavoriteEvent.self, forPrimaryKey: eventID) != nil
    }
    
    // Получение всех избранных событий
    func getFavorites() -> Results<FavoriteEvent> {
        return realm.objects(FavoriteEvent.self)
    }

}

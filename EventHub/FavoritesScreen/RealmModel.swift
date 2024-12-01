//
//  RealmModel.swift
//  EventHub
//
//  Created by apple on 11/30/24.
//
import Foundation
import RealmSwift

class FavoriteEvent: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var publicationDate: Int?
    @Persisted var descriptionText: String?
    @Persisted var imageURL: String?
    @Persisted var location: String?
}

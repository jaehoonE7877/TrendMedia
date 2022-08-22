//
//  RealmModel.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/08/22.
//

import Foundation
import RealmSwift

class UserShopping : Object {
    @Persisted var shoppingList: String
    @Persisted var updatedDate = Date()
    @Persisted var checkMark: Bool
    @Persisted var bookMark: Bool

    @Persisted(primaryKey: true) var objectId: ObjectId

    convenience init(shoppingList: String, updatedDate: Date) {
        self.init()
        self.shoppingList = shoppingList
        self.updatedDate = updatedDate
        self.checkMark = false
        self.bookMark = false
    }
}

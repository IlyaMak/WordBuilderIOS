//
//  Application.swift
//  WordBuilder
//
//  Created by ilya on 9.10.22.
//

import Foundation
import RealmSwift

//class Application: Codable {
//    var id: Int
//    var name: String
//    var token: String
//
//    init(id: Int, name: String, token: String) {
//        self.id = id
//        self.name = name
//        self.token = token
//    }
//}

class Application: Object, Identifiable  {
//    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(primaryKey: true) var _id: Int
    @Persisted var name: String
    @Persisted var token: String
}

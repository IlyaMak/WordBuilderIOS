//
//  Level.swift
//  WordBuilder
//
//  Created by ilya on 9.10.22.
//

import Foundation
import RealmSwift

class Level: Object, Identifiable, Decodable {
//    @Persisted(primaryKey: true) var _id: Int
//    @Persisted var number: Int
//    @objc var words: [String]
//    @Persisted var totalCompletions: Int
    
    @objc dynamic var id: Int = 0
    @objc dynamic var number = 0
    var words = List<String>()
    @objc dynamic var totalCompletions: Int = 0
}

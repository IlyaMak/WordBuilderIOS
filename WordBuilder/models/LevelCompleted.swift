//
//  LevelCompleted.swift
//  WordBuilder
//
//  Created by ilya on 18.11.22.
//

import Foundation
import RealmSwift

class LevelCompleted: Object, Identifiable  {
    @Persisted(primaryKey: true) var _id: Int
    @Persisted var levelId: Int
}

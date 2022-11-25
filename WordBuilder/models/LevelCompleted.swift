//
//  LevelCompleted.swift
//  WordBuilder
//
//  Created by ilya on 18.11.22.
//

import Foundation
import RealmSwift

class LevelCompleted: Object, Identifiable, Decodable  {
    @objc dynamic var id: Int
    @objc dynamic var levelId: Int
}

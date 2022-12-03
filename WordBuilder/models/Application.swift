//
//  Application.swift
//  WordBuilder
//
//  Created by ilya on 9.10.22.
//

import Foundation
import RealmSwift

class Application: Object, Identifiable  {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var token: String
}

//
//  Level.swift
//  WordBuilder
//
//  Created by ilya on 9.10.22.
//

import Foundation

struct Level: Identifiable, Codable {
    var id: Int
    var number: Int
    var words: [String]
    var totalCompletions: Int
}

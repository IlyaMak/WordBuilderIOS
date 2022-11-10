//
//  Leaders.swift
//  WordBuilder
//
//  Created by ilya on 21.10.22.
//

import Foundation

struct Leader: Identifiable, Decodable {
    var id: Int
    var name: String
    var amountOfWords: Int
    var isHighlighted: Bool
}

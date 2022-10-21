//
//  Application.swift
//  WordBuilder
//
//  Created by ilya on 9.10.22.
//

import Foundation

struct Application: Identifiable, Decodable {
    var id: Int
    var name: String
    var token: String
}

//
//  Endpoints.swift
//  WordBuilder
//
//  Created by ilya on 9.10.22.
//

import Foundation

class Endpoints {
    static let baseUrl: String = "https://word-constructor-web.vercel.app"
    static let getLeaders: String = baseUrl + "/api/leaders";
    static let getLevels: String = baseUrl + "/api/levels";
    static let applications: String = baseUrl + "/api/applications";
    static let levelsCompleted: String = baseUrl + "/api/levels-completed";
}

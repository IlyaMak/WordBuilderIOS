//
//  ViewRouter.swift
//  WordBuilder
//
//  Created by ilya on 18.10.22.
//

import SwiftUI
import RealmSwift

class ViewRouter: ObservableObject {
    let realm = try! Realm()
    var applications: Results<Application>? = nil
    @Published var currentPage: Page = .page1
    
    init() {
        if realm.objects(Application.self).count == 0 {
            currentPage = .page1
        } else {
            currentPage = .page2
        }
    }
}

//
//  WordBuilderApp.swift
//  WordBuilder
//
//  Created by ilya on 1.10.22.
//

import SwiftUI
import RealmSwift

@main
struct WordBuilderApp: SwiftUI.App {
    let realm = try! Realm()
    var applications: Results<Application>? = nil
    
    var body: some Scene {
        
        WindowGroup {
//            MotherView().environmentObject(viewRouter)
            if realm.objects(Application.self).count == 0 {
                Registration()
            } else {
                LevelScreen()
            }
        }
    }
}

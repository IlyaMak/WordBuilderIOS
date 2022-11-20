////
////  SplashScreen.swift
////  WordBuilder
////
////  Created by ilya on 19.11.22.
////
//
//import SwiftUI
//import RealmSwift
//
//struct SplashScreen: View {
//
//    var body: some View {
//
//        StartedView()
//    }
//}
//
//class StartedView: ObservableObject {
//    let realm = try! Realm()
//    var applications: Results<Application>? = nil
//    @Published var currentPage: Page = .page1
//
//    init() {
//        if realm.objects(Application.self).count == 0 {
//            Registration()
//        } else {
//            LevelScreen()
//        }
//    }
//}

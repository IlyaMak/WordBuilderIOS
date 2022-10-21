//
//  WordBuilderApp.swift
//  WordBuilder
//
//  Created by ilya on 1.10.22.
//

import SwiftUI

@main
struct WordBuilderApp: App {
//    var network = Network()
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
//            ContentView().environmentObject(network)
            MotherView().environmentObject(viewRouter)
        }
    }
}

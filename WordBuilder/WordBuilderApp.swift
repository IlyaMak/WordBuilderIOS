//
//  WordBuilderApp.swift
//  WordBuilder
//
//  Created by ilya on 1.10.22.
//

import SwiftUI

@main
struct WordBuilderApp: App {
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(viewRouter)
        }
    }
}

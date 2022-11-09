//
//  MotherView.swift
//  WordBuilder
//
//  Created by ilya on 18.10.22.
//

import SwiftUI
import RealmSwift

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
//    @ObservedResults(Application.self) var applications
    
    var body: some View {
        switch viewRouter.currentPage {
            case .page1:
                Registration()
            case .page2:
                LevelScreen()
                    .transition(.scale)
            case .page3:
                PlayableScreen()
                    .transition(.scale)
            case .page4:
                LeaderboardScreen()
                    .transition(.scale)
        }
    }
}
    
struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}

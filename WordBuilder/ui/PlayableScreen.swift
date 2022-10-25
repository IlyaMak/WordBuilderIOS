//
//  PlayableScreen.swift
//  WordBuilder
//
//  Created by ilya on 13.10.22.
//

import SwiftUI

struct PlayableScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var word: [String] = ["hello", "holla"]
    var letters: Array<Any> {
        get {
            return Array(Set(word.joined()))
        }
    }
    
    var body: some View {
        NavigationView {
            Text("\(letters)" as String)
                .navigationBarTitle("Play", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(
                        action: {
                            withAnimation {
                                viewRouter.currentPage = .page2
                            }
                        },
                        label: {
                            Image(systemName: "arrow.backward")
                        }
                    ),
                    trailing: Button(
                        action: {
                            withAnimation {
                                viewRouter.currentPage = .page4
                            }
                        },
                        label: {
                            Image(systemName: "crown.fill").foregroundColor(.yellow)
                        }
                    )
                )
        }
    }
}

struct PlayableScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlayableScreen().environmentObject(ViewRouter())
    }
}

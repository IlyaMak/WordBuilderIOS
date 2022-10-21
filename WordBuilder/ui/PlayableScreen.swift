//
//  PlayableScreen.swift
//  WordBuilder
//
//  Created by ilya on 13.10.22.
//

import SwiftUI

struct PlayableScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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

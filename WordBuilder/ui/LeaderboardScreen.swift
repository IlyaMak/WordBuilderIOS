//
//  LeaderboardScreen.swift
//  WordBuilder
//
//  Created by ilya on 20.10.22.
//

import SwiftUI

struct LeaderboardScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
//    @EnvironmentObject var network: Network
    
    var body: some View {
        NavigationView {
            ScrollView {
//                ForEach(network.leaders, id: \.id) { leader in
//                    Text("\(leader.id)")
//                }
            }
//            .onAppear {
//                network.getLeaders()
//            }
                .navigationBarTitle("Leaderboard", displayMode: .inline)
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
                        
                        },
                        label: {
                            Image(systemName: "crown.fill").foregroundColor(.yellow)
                        }
                    )
                )
        }
    }
}

struct LeaderboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardScreen().environmentObject(ViewRouter())
//        LeaderboardScreen().environmentObject(Network())
    }
}

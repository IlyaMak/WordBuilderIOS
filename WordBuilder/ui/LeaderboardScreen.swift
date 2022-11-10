//
//  LeaderboardScreen.swift
//  WordBuilder
//
//  Created by ilya on 20.10.22.
//

import SwiftUI

struct LeaderboardScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var leaders: [Leader] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List(leaders) { leader in
                    VStack {
                        HStack {
                            Text("\(leader.id)").bold()
                            Text(leader.name)
                        }
                        Text("\(leader.amountOfWords)")
                    }
                    .frame(width: 280, alignment: .leading)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
                }
                .onAppear {
                    Network().getLeaders { (leaders) in
                        self.leaders = leaders
                    }
                }
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
}

struct LeaderboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardScreen().environmentObject(ViewRouter())
    }
}

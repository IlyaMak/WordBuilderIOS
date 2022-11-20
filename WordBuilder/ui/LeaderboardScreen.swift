//
//  LeaderboardScreen.swift
//  WordBuilder
//
//  Created by ilya on 20.10.22.
//

import SwiftUI

struct LeaderboardScreen: View {
    @State var leaders: [Leader] = []
    @State private var showView = false
    
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
            }
        }
    }
}

struct LeaderboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardScreen()
    }
}

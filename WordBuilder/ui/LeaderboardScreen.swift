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
                List(leaders.indices, id: \.self) { index in
                    VStack {
                        HStack {
                            Text("\(index + 1)").bold()
                            Text(leaders[index].name)
                        }
                        Text("\(leaders[index].amountOfWords)")
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

//
//  LeaderboardScreen.swift
//  WordBuilder
//
//  Created by ilya on 20.10.22.
//

import SwiftUI
import RealmSwift

struct LeaderboardScreen: View {
    @AppStorage("isDarkMode") public var isDark = false
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    @State var leaders: [Leader] = []
    @State private var showView = false
    let application: Application
    
    init(application: Application) {
        self.application = application
    }
    
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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(leaders[index].isHighlighted ? Color.green : Color.purple)
                    .cornerRadius(10)
                }
                .onAppear {
                    Network().getLeaders(
                        application: application,
                        onSuccess: { (leaders) in
                            self.leaders = leaders
                        }
                    )
                }
                .navigationBarTitle("leaderboard_title".localized(language), displayMode: .inline)
            }
        }
        .preferredColorScheme(isDark ? .dark : .light)
    }
}

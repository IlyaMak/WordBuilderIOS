//
//  Level.swift
//  WordBuilder
//
//  Created by ilya on 6.10.22.
//

import SwiftUI
import RealmSwift

struct LevelScreen: View {
    @ObservedResults(Application.self) var applications
    @State private var showPlayableView = false
    @State private var showLeaderboardView = false
    @StateObject var realmManager = RealmManager()
    
    var body: some View {
        let realm = try! Realm()
        var levels: [Level] = []
        realm.objects(Level.self).forEach { level in
                    levels.append(level)
        }
        
        var nextLevelIndex = 0
        
        return NavigationView {
            VStack {
//                List(levels) { level in
//                    Text("All users").font(.title).bold()
//                            VStack {
//                                VStack(alignment: .leading) {
//                                    Text("\(level.number)").bold()
//
//                                    Text(level.words.joined(separator: ", "))
//
//                                    Text("\(level.totalCompletions)")
//                                }
//                            }
//                            .frame(width: 150, alignment: .leading)
//                            .padding()
//                            .background(Color.yellow)
//                            .cornerRadius(20)
//                }
//                .onAppear {
//                    Network().getLevels { (levels) in
//                        self.levels = levels
//                    }
//                }
                
                Text("\(applications.first?._id) \(applications.first?.name) \(applications.first?.token)" as String).padding()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle("Levels", displayMode: .inline)
                    .navigationBarItems(
                        trailing: Button(
                            action: {
                                self.showLeaderboardView.toggle()
                            },
                            label: {
                                Image(systemName: "crown.fill").foregroundColor(.yellow)
                            }
                        )
                        .sheet(isPresented: $showLeaderboardView) {
                            LeaderboardScreen()
                        }
                    )
                
                Button(action: {
                    self.showPlayableView.toggle()
                }, label: {
                    Image(systemName: "play")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Color.green
                                .cornerRadius(10)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        )
                })
                
                NavigationLink(
                    destination: PlayableScreen(levelIndex: nextLevelIndex, levelList: levels)
                        .navigationBarTitle("Level \(levels.count == 0 ? 0 : levels[nextLevelIndex].number)", displayMode: .inline)
                        .navigationBarItems(
                            trailing: Button(
                                action: {
                                    self.showLeaderboardView.toggle()
                                },
                                label: {
                                    Image(systemName: "crown.fill").foregroundColor(.yellow)
                                }
                            )
                            .sheet(isPresented: $showLeaderboardView) {
                                LeaderboardScreen()
                            }
                        ),
                    isActive: $showPlayableView,
                    label: {
                        
                    }
                )
            }
        }
    }
}

struct Level_Previews: PreviewProvider {
    static var previews: some View {
        LevelScreen()
    }
}

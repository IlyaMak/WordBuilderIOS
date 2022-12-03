//
//  Level.swift
//  WordBuilder
//
//  Created by ilya on 6.10.22.
//

import SwiftUI
import RealmSwift

struct LevelScreen: View {
    @ObservedResults(Application.self) var results
    @State private var showPlayableView = false
    @State private var showLeaderboardView = false
    @State private var viewId: Int = 0
//    @StateObject var realmManager = RealmManager()
    
    var body: some View {
        let realm = try! Realm()
        var levels: [Level] = []
        realm.objects(Level.self).forEach { level in
            levels.append(level)
        }
        
        var levelCompleted: [LevelCompleted]? = []
        realm.objects(LevelCompleted.self).forEach { levelCompletedRecord in
            levelCompleted?.append(levelCompletedRecord)
        }
        
        var nextLevelIndex = levelCompleted!.isEmpty ? 0 : (levels.firstIndex(where: {$0.id == levelCompleted?.last?.levelId}))! + 1
        
        var nextLevelNumber = 1
        var areAllLevelsCompleted = false
        
        if((levels.first(where: {$0 == levels[nextLevelIndex]})?.number) != nil) {
            nextLevelNumber = levels[nextLevelIndex].number
        } else {
            nextLevelNumber = 1
            nextLevelIndex = 0
            areAllLevelsCompleted = true
        }
        
        return NavigationView {
            VStack {
                Text(areAllLevelsCompleted ? "All levels are completed. Come back later!" : "Level \(nextLevelNumber)")
                    .id(viewId)
                
                Text("\(results.first?.id) \(results.first?.name) \(results.first?.token)" as String).padding()
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
                    destination: PlayableScreen(levelIndex: nextLevelIndex, levelList: levels, application: results.first!)
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
                            .onDisappear {
                                viewId += 1
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

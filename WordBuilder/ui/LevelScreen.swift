//
//  Level.swift
//  WordBuilder
//
//  Created by ilya on 6.10.22.
//

import SwiftUI
import RealmSwift

struct LevelScreen: View {
    @AppStorage("isDarkMode") public var isDark = false
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    @ObservedResults(Application.self) var results
    @State private var showPlayableView = false
    @State private var showLeaderboardView = false
    @State private var showSettingsView = false
    @State private var viewId: Int = 0
    
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
                Text(areAllLevelsCompleted ? "level_screen_if_all_levels_are_completed".localized(language) : "level_screen_level_number".localized(language) + String(nextLevelNumber))
                    .foregroundColor(.purple)
                    .font(.system(size: 28))
                    .id(viewId)
                    .padding()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle("level_screen_title".localized(language), displayMode: .inline)
                    .navigationBarItems(
                        trailing:
                            HStack {
                                Button(
                                    action: {
                                        self.showLeaderboardView.toggle()
                                    },
                                    label: {
                                        Image(systemName: "crown.fill").foregroundColor(.yellow)
                                    }
                                )
                                .padding(.horizontal, 20)
                                .sheet(isPresented: $showLeaderboardView) {
                                    LeaderboardScreen(application: results.first!)
                                }
                                
                                Button(
                                    action: {
                                        self.showSettingsView.toggle()
                                    },
                                    label: {
                                        Image(systemName: "gearshape.fill").foregroundColor(isDark ? .white : .black)
                                    }
                                )
                                .sheet(isPresented: $showSettingsView) {
                                    SettingsScreen()
                                }
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
                .opacity(areAllLevelsCompleted ? 0 : 1)
                
                NavigationLink(
                    destination: PlayableScreen(levelIndex: nextLevelIndex, levelList: levels, application: results.first!)
                        .navigationBarItems(
                            trailing:
                                HStack {
                                    Button(
                                        action: {
                                            self.showLeaderboardView.toggle()
                                        },
                                        label: {
                                            Image(systemName: "crown.fill").foregroundColor(.yellow)
                                        }
                                    )
                                    .padding(.horizontal, 20)
                                    .sheet(isPresented: $showLeaderboardView) {
                                        LeaderboardScreen(application: results.first!)
                                    }
                                    .onDisappear {
                                        viewId += 1
                                    }
                                    
                                    Button(
                                        action: {
                                            self.showSettingsView.toggle()
                                        },
                                        label: {
                                            Image(systemName: "gearshape.fill").foregroundColor(isDark ? .white : .black)
                                        }
                                    )
                                    .sheet(isPresented: $showSettingsView) {
                                        SettingsScreen()
                                    }
                                }
                                
                        ),
                    isActive: $showPlayableView,
                    label: {
                        
                    }
                )
            }
        }
        .preferredColorScheme(isDark ? .dark : .light)
    }
}

struct Level_Previews: PreviewProvider {
    static var previews: some View {
        LevelScreen()
    }
}

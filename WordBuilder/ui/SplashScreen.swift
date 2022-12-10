//
//  SplashScreen.swift
//  WordBuilder
//
//  Created by ilya on 19.11.22.
//

import SwiftUI
import RealmSwift

struct SplashScreen: View {
    @State var levels: [Level] = []
    @State private var isActive = false
    var applications: Results<Application>? = nil
    @AppStorage("isDarkMode") public var isDark = false
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    init() {
        //check if all api levels equals to realm levels - not save
        let realm = try! Realm()
        Network().getLevels { (levelsFromApi) in
            
            if(levelsFromApi.count != realm.objects(Level.self).count) {
                try! realm.write {
                    realm.add(levelsFromApi)
                }
            }
        }
    }

    var body: some View {
        if isActive {
            let realm = try! Realm()
            if realm.objects(Application.self).count == 0 {
                Registration()
            } else {
                LevelScreen()
            }
        } else {
            Text("splash_screen_label".localized(language))
                .preferredColorScheme(isDark ? .dark : .light)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.isActive = true
                }
            }
        }
    }
}

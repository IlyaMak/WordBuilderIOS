//
//  Registration.swift
//  WordBuilder
//
//  Created by ilya on 6.10.22.
//

import SwiftUI
import RealmSwift

struct Registration: View {
    @State private var name = ""
    @State private var showLevelView = false
    @State private var showLeaderboardView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello \(name)")
                TextField("Enter your name", text:$name)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                        
                Button(
                    action: {
                        let application = Application()
                        application.name = name
                        application.token = "1234567890"
                        
                        let realm = try! Realm()
                        try! realm.write {
                            realm.add(application)
                        }
                        
                        self.showLevelView.toggle()
                }, label: {
                    Text("Register".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Color.purple
                                .cornerRadius(10)
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        )
                    })
                
                NavigationLink(
                    destination: LevelScreen().navigationBarHidden(true),
                    isActive: $showLevelView,
                    label: {
                        
                    }
                )
            }
        }
    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        Registration()
    }
}

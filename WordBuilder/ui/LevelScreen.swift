//
//  Level.swift
//  WordBuilder
//
//  Created by ilya on 6.10.22.
//

import SwiftUI
import RealmSwift

struct LevelScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var levels: [Level] = []
    @ObservedResults(Application.self) var applications
    
    var body: some View {
        NavigationView {
            VStack {
                List(levels) { level in
                    Text("All users").font(.title).bold()
                            VStack {
                                VStack(alignment: .leading) {
                                    Text("\(level.number)").bold()

                                    Text(level.words.joined(separator: ", "))

                                    Text("\(level.totalCompletions)")
                                }
                            }
                            .frame(width: 150, alignment: .leading)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(20)
                }
                .onAppear {
                    Network().getLevels { (levels) in
                        self.levels = levels
                    }
                }
                
                Text("\(applications.first?._id) \(applications.first?.name) \(applications.first?.token)" as String).padding()
                    .navigationBarTitle("Levels", displayMode: .inline)
                    .navigationBarItems(
                        trailing: Button(
                            action: {
                                withAnimation {
                                    viewRouter.currentPage = .page4
                                }
                            },
                            label: {
                                Image(systemName: "crown.fill").foregroundColor(.yellow)
                            }
                        )
                    )
                
                Button(action: {
                    withAnimation {
                        viewRouter.currentPage = .page3
                    }
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
                }
                )
            }
        }
    }
}

struct Level_Previews: PreviewProvider {
    static var previews: some View {
        LevelScreen().environmentObject(ViewRouter())
    }
}

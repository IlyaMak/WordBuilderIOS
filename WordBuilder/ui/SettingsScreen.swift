//
//  SettingsScreen.swift
//  WordBuilder
//
//  Created by ilya on 6.12.22.
//

import SwiftUI

struct SettingsScreen: View {
    @AppStorage("isDarkMode") public var isDark = false
    
    var body: some View {
        VStack {
            Button(
                action: {
                    isDark.toggle()
                },
                label: {
                    isDark ? Label("Dark theme", systemImage: "lightbulb.fill") : Label("Light theme", systemImage: "lightbulb")
                }
            )
            .padding(.vertical, 30)
        }
        .preferredColorScheme(isDark ? .dark : .light)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}

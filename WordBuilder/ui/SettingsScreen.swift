//
//  SettingsScreen.swift
//  WordBuilder
//
//  Created by ilya on 6.12.22.
//

import SwiftUI

struct SettingsScreen: View {
    @AppStorage("isDarkMode") public var isDark = false
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    var body: some View {
        VStack {
            Button(
                action: {
                    isDark.toggle()
                },
                label: {
                    isDark ? Label("settings_dark_theme_label".localized(language), systemImage: "lightbulb.fill") : Label("settings_light_theme_label".localized(language), systemImage: "lightbulb")
                }
            )
            .padding(.vertical, 30)
            
            Menu {
                Button {
                    LocalizationService.shared.language = .russian
                } label: {
                    Text("Русский")
                }
                Button {
                    LocalizationService.shared.language = .english_us
                } label: {
                    Text("English (US)")
                }
            }
            label: {
                Label("settings_choose_language_label".localized(language), systemImage:"arrow.up.left.and.arrow.down.right")
            }
        }
        .preferredColorScheme(isDark ? .dark : .light)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    }
}

//
//  Settings.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 24/02/24.
//

import SwiftUI

struct Settings: View {
    let settingsOptions: [SettingOption] = [
//            SettingOption(title: "Language", iconName: "globe"),
//            SettingOption(title: "Rate Us on the App Store", iconName: "star.fill"),
            SettingOption(title: "Release Notes", iconName: "doc.plaintext"),
            SettingOption(title: "View Website", iconName: "network"),
//            SettingOption(title: "Notifications", iconName: "bell.fill"),
            SettingOption(title: "Privacy Policy", iconName: "lock.fill")
        ]
    
    var body: some View {
        NavigationStack {
                List(settingsOptions) { option in
                    Button(action: {
                        performAction(for: option)
                    }) {
                        HStack {
                            Image(systemName: option.iconName)
                                .foregroundColor(.blue)
                                .frame(width: 24, height: 24)
                            Text(option.title)
                            Spacer()
                        }
                        .padding(.vertical, 8)
    //                    Divider()
                    }
                    .background(Color.white) // Set the background color of the NavigationStack
                    
                    
                }
                .listStyle(PlainListStyle()) // Use PlainListStyle for more control over appearance
                .background(Color.white) // Set the background color of the NavigationStack
            .navigationTitle("About")
            
            BannerAdView()
                .frame(width: 400, height: 50, alignment: .center)
                .background(Color.white)

        }

    }
}

func performAction(for option: SettingOption) {
    switch option.title {
    case "Language":
        // navigate to language selection sceen
        print("Language Selector")
        break
    case "Rate Us on the App Store":
        if let url = URL(string: "https://apps.apple.com/in/app/google-chrome/id535886823") {
            UIApplication.shared.open(url)
        }
    case "View Developer's Website":
        if let url = URL(string: "https://amartyadav.tech/") {
            UIApplication.shared.open(url)
        }
        
    case "Release Notes":
        if let url = URL(string: "https://aatmamartya.notion.site/Mandi-Mitra-Release-Notes-iOS-d0ebda548533482c9fbda9692a28e8a2?pvs=4") {
            UIApplication.shared.open(url)
        }
        
    case "Privacy Policy":
        if let url = URL(string: "https://docs.google.com/document/d/1xjscbL1W_GOkL2C4xp_o-ILJhdr_hRq5iTRiOJVcN9w/edit?usp=sharing") {
            UIApplication.shared.open(url)
        }
        
    default:
        break
    }
}

#Preview {
    Settings()
}

struct SettingOption: Identifiable {
    var id = UUID()
    var title: String
    var iconName: String
}

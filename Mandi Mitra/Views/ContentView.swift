//
//  ContentView.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 24/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingWelcomeAndName = UserDefaults.standard.string(forKey: "userName") == nil
    
    @State private var showingUpdateAlert = false
    
    
    var body: some View {
        if showingWelcomeAndName {
            WelcomeAndName(showingWelcomeAndName: $showingWelcomeAndName)
        }
        else {
            TabView {
                ItemEntry()
                    .tabItem { Label("Item Entry", systemImage: "list.bullet") }
                Settings()
                    .tabItem({
                        Label("About", systemImage: "info.circle")
                    })
            }
        }
        
    }
}

#Preview {
    ContentView()
}

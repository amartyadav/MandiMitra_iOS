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
    
    @StateObject private var updateCheckerViewModel = UpdateCheckerViewModel()
    var body: some View {
        if showingWelcomeAndName {
            WelcomeAndName(showingWelcomeAndName: $showingWelcomeAndName)
        }
        else {
            TabView {
                ItemEntry()
                    .tabItem { Label("Item Entry", systemImage: "list.bullet") }
                    .onAppear {
                        updateCheckerViewModel.checkForUpdates()
                    }
                    .onChange(of: updateCheckerViewModel.isUpdateAvailable) { isAvailable in
                        showingUpdateAlert = isAvailable
                    }
                    .alert(isPresented: $showingUpdateAlert, content: {
                        Alert(
                            title: Text("New Version Available"),
                            message: Text("A new version of Mandi Mitra is available!🔥\nUpdate now for the latest features 😍"),
                            primaryButton: .default(Text("Update Now")) {
                                UIApplication.shared.open(URL(string: "https://apps.apple.com/in/app/mandi-mitra/id6478404044")!)
                            },
                            secondaryButton: .destructive(Text("Update Later"))
                        )
                    })
                
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

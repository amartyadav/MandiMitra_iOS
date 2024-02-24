//
//  ContentView.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 24/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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

#Preview {
    ContentView()
}

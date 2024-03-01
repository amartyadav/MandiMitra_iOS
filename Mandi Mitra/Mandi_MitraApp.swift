//
//  Mandi_MitraApp.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 13/02/24.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

@main
struct Mandi_MitraApp: App {
    init() {
        // initialise Google ADMob SDK
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


//
//  WelcomeAndName.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 28/02/24.
//

import SwiftUI

struct WelcomeAndName: View {
    @Binding var showingWelcomeAndName: Bool
    @State private var userName: String = ""
    
    var body: some View {
        VStack {
                    TextField("Enter your name", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Continue") {
                        UserDefaults.standard.set(userName, forKey: "userName")
                        showingWelcomeAndName = false
                    }
                    .disabled(userName.isEmpty)
                }
                .padding()    }
}

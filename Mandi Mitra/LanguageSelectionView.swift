//
//  LanguageSelectionView.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 24/02/24.
//

import SwiftUI

struct LanguageSelectionView: View {
    let languages = [
        ("English", "en"),
        ("Hindi", "hi")
    ]
    
    var body: some View {
        List(languages, id: \.1) { language in
            Button(language.0) {
                
            }
        }
    }
}

#Preview {
    LanguageSelectionView()
}

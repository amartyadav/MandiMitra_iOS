//
//  Extensions.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 01/03/24.
//

import Foundation
import SwiftUI


extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}

extension Color {
    static let mandiMitraPrimary = Color(hex: "f3fbee")
    static let mandiMitraText = Color(hex: "274029")
    static let mandiMitraOnPrimary = Color.white
    static let mandiMitraActionableButtons = Color(hex: "313b72")
    
    // Dark Theme Colors
    static let mandiMitraDarkPrimary = Color(hex: "0xFF81C784")
    static let mandiMitraDarkOnPrimary = Color.black
    static let mandiMitraDarkSecondary = Color(hex: "0xFFFFB74D")
    static let mandiMitraDarkOnSecondary = Color.black
    static let mandiMitraDarkBackground = Color(hex: "0xFF303030")
    static let mandiMitraDarkOnBackground = Color.white
    static let mandiMitraDarkSurface = Color(hex: "0xFF424242")
    static let mandiMitraDarkOnSurface = Color.white
    static let mandiMitraDarkError = Color(hex: "0xFFE57373")
    static let mandiMitraDarkOnError = Color.black
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

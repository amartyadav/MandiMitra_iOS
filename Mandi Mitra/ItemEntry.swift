//
//  ItemEntry.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 13/02/24.
//

import SwiftUI

struct ItemEntry: View {
    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .top)
                {
                    RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                            .foregroundColor(Color(hex: "#87eaa4"))
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    VStack{
                        HStack{
                            Text("Enter Item Rate")
                                .padding(EdgeInsets(top: 13, leading: 20, bottom: 10, trailing: 15))
                                .font(.title2)
                            Spacer()
                        }
                        HStack{
                            Image("ruppee_icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 20)
                                .padding(.leading, 20)
                            Spacer()
                        }
                    }           
                    .multilineTextAlignment(.center)
                }
                .padding(20)
                .frame(width: 450, height: 250)

                Spacer()
            
            }
            .toolbar {
                ToolbarItem {
                    Label("Add Item", systemImage: "plus")
                }
            }
            .navigationTitle("Item Entry")
        }
    }
}

#Preview {
    ItemEntry()
}

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

//
//  ItemEntry.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 13/02/24.
//

import SwiftUI

struct ItemEntry: View {
    @State var buyingItemRate: String = ""
    enum itemRateQuantity: String, CaseIterable, Identifiable {
        case KG, Paao
        var id: Self {self}
    }
    @State private var selectedSellingUnit: itemRateQuantity = .Paao
    
    enum buyingQuantity: String, CaseIterable, Identifiable {
        case one_paao = "1 Paao", half_kg = "Half KG", three_paao = "3 Paao", one_kg = "1 KG", more_kg = "More KG"
        var id: Self {self}
    }
    
    @State private var selectedBuyingQuantity: buyingQuantity = .one_paao
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .top)
                {
                    
                    RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                            .foregroundColor(Color(hex: "#ffffff"))
                    VStack{
                        HStack{
                            Text("Enter Item Rate")
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 30, trailing: 15))
                                .font(.title2)
                            Spacer()
                        }
                        HStack{
                            Group{
                                Group{
                                    Image("ruppee_icon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 20)
                                        .padding(.leading, 20)
                                    TextField("", text: $buyingItemRate)
                                        .padding(.leading, 10)
                                        .frame(width: 100)
                                        .keyboardType(.decimalPad)
                                }
                                .textFieldStyle(.roundedBorder)
                                .font(Font.system(size: 40, design: .default))
                                .multilineTextAlignment(.center)
                                
                                
                                Picker("Unit", selection: $selectedSellingUnit) {
                                    ForEach(itemRateQuantity.allCases) { unit in
                                        Text(unit.rawValue)
                                    }
                                }.tint(Color.black)
                                .onTapGesture {
                                        hideKeyboard()
                                }
                                
                            }
                            
                            
                            
                            Spacer()
                        }
                    }           
                    .multilineTextAlignment(.center)
                }
                .padding(EdgeInsets(top: 10, leading: 35, bottom: 0, trailing: 35))
                .frame(width: 450, height: 200)

                // buying section
                ZStack(alignment: .top)
                {
                    
                    RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                            .foregroundColor(Color(hex: "#ffffff"))
                    VStack{
                        HStack{
                            Text("You Want To Buy")
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 30, trailing: 15))
                                .font(.title2)
                            Spacer()
                        }
                        HStack{
//                            Group{
//                                Group{
//                                    Image("ruppee_icon")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 25, height: 20)
//                                        .padding(.leading, 20)
//                                    TextField("", text: $buyingItemRate)
//                                        .padding(.leading, 10)
//                                        .frame(width: 100)
//                                        .keyboardType(.decimalPad)
//                                }
//                                .textFieldStyle(.roundedBorder)
//                                .font(Font.system(size: 40, design: .default))
//                                .multilineTextAlignment(.center)
                                
                                HStack{
                                    Text("Desired Quantity")
                                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                    Picker("Unit", selection: $selectedBuyingQuantity) {
                                        ForEach(buyingQuantity.allCases) { unit in
                                            Text(unit.rawValue)
                                        }
                                    }.tint(Color.black)
                                    .onTapGesture {
                                            hideKeyboard()
                                    }
                                }
                                
                                
                                

                                
                                
//                            }
                            
                            
                            
                            Spacer()
                        }
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 35, bottom: 0, trailing: 35))
                .frame(width: 450, height: 200)

                Spacer()
            
            }
            .background(Color(hex: "f2f2f7"))
            .toolbar {
                ToolbarItem {
                    Label("Add Item", systemImage: "plus")
                }
            }
            .navigationTitle("Mandi Mitra")
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

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

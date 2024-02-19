//
//  ItemEntry.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 13/02/24.
//

import SwiftUI

struct ItemEntry: View {
    @State var buyingItemRate: String = ""
    @State var totalAmount: String = "0.0"
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
            ScrollView{
                VStack {
                    
                    ItemRateEntrySection(buyingItemRate: $buyingItemRate, selectedSellingUnit: $selectedSellingUnit)
                                        
                    BuyingSection(selectedBuyingQuantity: $selectedBuyingQuantity, buyingItemRate: $buyingItemRate)

                    TotalSection(totalAmount: $totalAmount)
                    
                    Spacer()

                }
            }                
            .background(Color(hex: "f2f2f7"))
            .toolbar {
                ToolbarItem {
                    Label("Add Item", systemImage: "gear")
                }
            }
            .navigationTitle("Mandi Mitra")
        }
    }

}

func addItemToList() -> Void {
    print("Add Item to list clicked")
}

#Preview {
    ItemEntry()
}

struct ItemRateEntrySection: View {
    @Binding var buyingItemRate: String
    @Binding var selectedSellingUnit: ItemEntry.itemRateQuantity
    
    var body: some View {
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
                            ForEach(ItemEntry.itemRateQuantity.allCases) { unit in
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

    }
}

struct BuyingSection: View {
    @Binding var selectedBuyingQuantity: ItemEntry.buyingQuantity
    @Binding var buyingItemRate: String
    var body: some View {
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
                        HStack{
                            Text("Desired Quantity")
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            Picker("Unit", selection: $selectedBuyingQuantity) {
                                ForEach(ItemEntry.buyingQuantity.allCases) { unit in
                                    Text(unit.rawValue)
                                }
                            }.tint(Color.black)
                            .onTapGesture {
                                    hideKeyboard()
                            }
                            .onChange(of: selectedBuyingQuantity) { newValue in
                                if newValue == .more_kg {
                                    print("More KG selected")
                                }
                            }
                        }
                    Spacer()
                }
                
                // More KG Input text field
                if selectedBuyingQuantity == .more_kg {
                    HStack{
                        TextField("More KG", text: $buyingItemRate)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                            .frame(width: 150)
                        Text("KG")
                    }
                }
                HStack{
                    Spacer()
                    Button {
                        addItemToList()
                    } label: {
                        Label("Add To List", systemImage: "cart.badge.plus")
                            .font(.body)
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                

                 
            }
        }
        .padding(EdgeInsets(top: 30, leading: 35, bottom: 0, trailing: 35))
        .frame(width: 450, height: 200)
    }
}

struct TotalSection: View {
    @Binding var totalAmount: String
    var body: some View {
        ZStack(alignment: .top)
        {
            
            RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                .foregroundColor(Color(hex: "#ffffff"))
            HStack{
                Text("Total: \u{20B9}")
                Text(totalAmount)
                Spacer()
                Button {
                    addItemToList()
                } label: {
                    Label("View Bill", systemImage: "cart.badge.plus")
                        .font(.body)
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 10))

        }
        .padding(EdgeInsets(top: 30, leading: 35, bottom: 0, trailing: 35))
        .frame(width: 450, height: 100)

    }
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

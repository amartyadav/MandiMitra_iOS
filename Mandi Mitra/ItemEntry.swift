//
//  ItemEntry.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 13/02/24.
//

import SwiftUI

struct ItemEntry: View {
    // selling section (Enter Item Rate) section variables
    /// The price at which the item is being sold (only the numerical value without the quantity of the rate)
    @State var sellingItemPrice: String = ""
    /// Enum for all the various quantities that the item is being sold in. For eg. "Rs. 12/paao or Rs. 12/kg"
    enum sellingItemUnit: String, CaseIterable, Identifiable {
        case KG, Paao
        var id: Self {self}
    }
    /// Holds the selected unit that the item is being sold in at the shop. For eg. "Paao" for an item of rate "Rs. 12/paao"
    @State private var selectedSellingItemUnit: sellingItemUnit = .Paao
    
    // ---------------------------------------
    
    // buying section (You Want To Buy) section variables
    /// Enum for all the various quantities that the user can choose to buy for an item
    enum buyingQuantity: String, CaseIterable, Identifiable {
        case one_paao = "1 Paao", half_kg = "Half KG", three_paao = "3 Paao", one_kg = "1 KG", more_kg = "More KG"
        var id: Self {self}
    }
    /// The selected quantity that the suer wishes to buy for a particular item
    @State private var selectedBuyingQuantity: buyingQuantity = .one_paao
    /// Holds the custom KG value if "More KG" is selected as the buying quantity
    @State private var customKGQuantity: String = "0.0"
    
    // ---------------------------------------
    
    
    // Total section variables
    /// Stores the total amount to be paid for all the items added to the bill
    @State var totalAmount: String = "0.0"
    
    // ---------------------------------------

    // List to hold all the items added to the bill
    /// Holds all the items added to the bill
    @State private var itemsList: [ItemDetail] = []
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack {
                    
                    ItemRateEntrySection(sellingItemPrice: $sellingItemPrice, selectedSellingItemUnit: $selectedSellingItemUnit)
                                        
                    BuyingSection(
                        totalAmount: $totalAmount,
                        sellingItemPrice: $sellingItemPrice,
                        selectedSellingUnit: $selectedSellingItemUnit,
                        selectedBuyingQuantity: $selectedBuyingQuantity,
                        customKGQuantity: $customKGQuantity,
                        onAddItem: { price, unit, quantity, customQuantity, _ in
                                // Calculate total cost using ItemTotalCalculator
                                let totalCost = ItemTotalCalculator.calculateItemTotal(
                                    price: price,
                                    sellingQuantityUnitSelected: unit,
                                    buyingQuantityUnitSelected: quantity,
                                    customQuantity: customQuantity
                                )
                                
                                // Create new item detail
                                let newItem = ItemDetail(
                                    sellingRate: "\(price)/\(unit.rawValue)",
                                    buyingQuantity: quantity.rawValue,
                                    totalAmount: String(totalCost),
                                    customKGQuantity: customQuantity ?? "0"
                                )
                                
                                // Append new item to the list
                                itemsList.append(newItem)
                            
                            print(itemsList)
                                
                                // Optionally update total amount if needed
                                // This depends on how you manage totalAmount in your app
                        }
                    )

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

///// Function to add the Item to the itemsList: [ItemDetail] list.
//func addItemToList(
//    sellingItemPrice: String,
//    selectedSellingItemUnit: ItemEntry.sellingItemUnit,
//    selectedBuyingQuantity: String,
//    customKGQuantity: String?,
//    totalAmount: String
//) -> Void {
//    @Binding var itemsList: [ItemDetail]
//    print("Add Item to list clicked")
//    let sellingRate = sellingItemPrice + selectedSellingItemUnit.rawValue
//    let newItem = ItemDetail(sellingRate: sellingRate, buyingQuantity: selectedBuyingQuantity, totalAmount: totalAmount, customKGQuantity: customKGQuantity)
//    itemsList.append(newItem)
//}

#Preview {
    ItemEntry()
}


struct ItemRateEntrySection: View {
    @Binding var sellingItemPrice: String
    @Binding var selectedSellingItemUnit: ItemEntry.sellingItemUnit
    
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
                            TextField("", text: $sellingItemPrice)
                                .padding(.leading, 10)
                                .frame(width: 100)
                                .keyboardType(.decimalPad)
                        }
                        .textFieldStyle(.roundedBorder)
                        .font(Font.system(size: 40, design: .default))
                        .multilineTextAlignment(.center)
                        
                        
                        Picker("Unit", selection: $selectedSellingItemUnit) {
                            ForEach(ItemEntry.sellingItemUnit.allCases) { unit in
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
    @Binding var totalAmount: String
    @Binding var sellingItemPrice: String
    @Binding var selectedSellingUnit: ItemEntry.sellingItemUnit
    @Binding var selectedBuyingQuantity: ItemEntry.buyingQuantity
    @Binding var customKGQuantity: String
    
    // closure property
    var onAddItem: (String, ItemEntry.sellingItemUnit, ItemEntry.buyingQuantity, String?, String) -> Void
    
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
                        TextField("More KG", text: $customKGQuantity)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                            .frame(width: 150)
                        Text("KG")
                    }
                }
                HStack{
                    Spacer()
                    Button {
                        onAddItem(sellingItemPrice, selectedSellingUnit, selectedBuyingQuantity, customKGQuantity, totalAmount)
                        
                    }
                label: {
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

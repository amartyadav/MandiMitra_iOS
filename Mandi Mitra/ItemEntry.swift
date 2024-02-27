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
    @State private var customKGQuantity: String = ""
    
    // ---------------------------------------
    
    
    /// Stores the total amount to be paid for a item added to the bill
    @State var totalItemAmount: String = "0.0"
    
    /// Stores the total bill amount
    @State var totalBillAmount: String = "0.00"
    
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
                        totalItemAmount: $totalItemAmount,
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
                                    totalItemAmount: String(totalCost),
                                    customKGQuantity: customQuantity ?? "0"
                                )
                                
                                // Append new item to the list
                                itemsList.append(newItem)
                            
                            print(itemsList)
                            
                            if let currentTotal = Double(totalBillAmount) {
                                let newTotal = currentTotal + totalCost
                                totalBillAmount = String(format: "%.2f", newTotal)
                            }
                            
                                
                                // Optionally update total amount if needed
                                // This depends on how you manage totalAmount in your app
                        }
                    )

                    TotalSection(totalBillAmount: $totalBillAmount, itemsList: $itemsList)
                    
                    Spacer()

                }
            }     
            .padding(.top, 20) // Adjust the value to create desired space

            .background(Color(hex: "f3fbee"))
//            .toolbar {
//                ToolbarItem {
//                    Label("Add Item", systemImage: "gear")
//                }
//            }
//            .navigationTitle("Mandi Mitra")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                            HStack {
                                Image("final_app_icon") // Replace "appIcon" with your actual icon name
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                Text("Mandi Mitra")
                                    .font(.largeTitle)
                            }
                        }
                    }
            
        }
    }

}

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
                .foregroundColor(Color.mandiMitraPrimary)
                .shadow(radius: 3)
            VStack{
                HStack{
                    Text("Enter Item Rate")
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 30, trailing: 15))
                        .font(.title2)
                        .foregroundColor(Color.mandiMitraText)
                    Spacer()
                }
                HStack{
                    Group{
                        Group{
                            if !sellingItemPrice.isEmpty {
                                        Image("ruppee_icon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 25, height: 20)
                                            .padding(.leading, 20)
                                    }
                            TextField("₹", text: $sellingItemPrice)
                                .padding(.leading, 10)
                                .frame(width: 100)
                                .keyboardType(.decimalPad)
                                .foregroundColor(Color.mandiMitraText)
                        }
                        .font(Font.system(size: 40, design: .default))
                        .multilineTextAlignment(.center)
                        
                        
                        Picker("Unit", selection: $selectedSellingItemUnit) {
                            ForEach(ItemEntry.sellingItemUnit.allCases) { unit in
                                Text(unit.rawValue)
                                    .foregroundColor(Color.mandiMitraText)
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
        .padding(EdgeInsets(top: 10, leading: 35, bottom: 20, trailing: 35))
        .frame(width: 450, height: 200)

    }
}

struct BuyingSection: View {
    @Binding var totalItemAmount: String
    @Binding var sellingItemPrice: String
    @Binding var selectedSellingUnit: ItemEntry.sellingItemUnit
    @Binding var selectedBuyingQuantity: ItemEntry.buyingQuantity
    @Binding var customKGQuantity: String
    
    // Add a computed property to determine the additional padding
        var additionalPadding: CGFloat {
            selectedBuyingQuantity == .more_kg ? 90 : 10 // Adjust the value as needed
        }
    
    // closure property
    var onAddItem: (String, ItemEntry.sellingItemUnit, ItemEntry.buyingQuantity, String?, String) -> Void
    
    var body: some View {
        // buying section
        ZStack(alignment: .top)
        {
            
            RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                .foregroundColor(Color.mandiMitraPrimary)
                .shadow(radius: 3)
            VStack{
                HStack{
                    Text("You Want To Buy")
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 30, trailing: 15))
                        .font(.title2)
                        .foregroundColor(Color.mandiMitraText)
                    Spacer()
                }
                HStack{
                        HStack{
                            Text("Desired Quantity")
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                .foregroundColor(Color.mandiMitraText)

                            Picker("Unit", selection: $selectedBuyingQuantity) {
                                ForEach(ItemEntry.buyingQuantity.allCases) { unit in
                                    Text(unit.rawValue)
                                        .foregroundColor(Color.mandiMitraText)

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
                            .padding(.leading, 10)
                            .frame(width: 100)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                            .background(Color.mandiMitraPrimary)
                            .foregroundColor(Color.mandiMitraText)

                        Text("KG")
                            .foregroundColor(Color.mandiMitraText)

                    }
                }
                HStack{
                    Spacer()
                    Button {
                        onAddItem(sellingItemPrice, selectedSellingUnit, selectedBuyingQuantity, customKGQuantity, totalItemAmount)
                        
                    }
                label: {
                        Label("Add To List", systemImage: "plus.circle")
                            .font(.body)
                            .foregroundColor(Color.mandiMitraActionableButtons)
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
//                    .background(Color.blue)
//                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                

                 
            }
        }
        .padding(EdgeInsets(top: additionalPadding, leading: 35, bottom: additionalPadding, trailing: 35))
        .frame(width: 450, height: 200)
    }
}

struct TotalSection: View {
    @Binding var totalBillAmount: String
    @Binding var itemsList: [ItemDetail]
    
    var body: some View {
        ZStack(alignment: .top)
        {
            
            RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                .foregroundColor(Color.mandiMitraPrimary)
                .shadow(radius: 3)
            HStack{
                Text("Total: \u{20B9}")
                    .foregroundColor(Color.mandiMitraText)
                Text(totalBillAmount)
                    .foregroundColor(Color.mandiMitraText)
                Spacer()
                NavigationLink(destination: ViewDetailedList(items: itemsList)) {
                                    Label("View Bill", systemImage: "cart.badge.plus")
                                        .font(.body)
                                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                        .foregroundColor(Color.mandiMitraActionableButtons)
                                        .cornerRadius(10)
                                }
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 10))

        }
        .padding(EdgeInsets(top: 30, leading: 35, bottom: 0, trailing: 35))
        .frame(width: 450, height: 100)

    }
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

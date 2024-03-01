//
//  ItemEntry.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 13/02/24.
//

import SwiftUI


struct ItemEntry: View {
//    init() {
//        UINavigationBar.appearance().backgroundColor = UIColor.systemBlue
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
//    }
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
            Divider()
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            ScrollView{
                VStack {
                    HStack{
                        Text("Hello, \(UserDefaults.standard.string(forKey: "userName") ?? "Guest")")
                            .font(.title)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    
                    GeometryReader { geometry in
                        HStack(spacing: 8) {
                            ItemRateEntrySection(sellingItemPrice: $sellingItemPrice, selectedSellingItemUnit: $selectedSellingItemUnit)
                                .frame(width: geometry.size.width * 0.5 - 4) // Half width minus half spacing

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
                                }
                            )
                            .frame(width: geometry.size.width * 0.5 - 4) // Half width minus half spacing

                        }
                        .frame(height: 180) // Set a fixed height for your HStack
                    }
                    .padding(.top, 10)
                    .frame(height: 180) // Ensure GeometryReader has a defined height

                    
                    TotalSection(totalBillAmount: $totalBillAmount, itemsList: $itemsList)
                            .padding(.horizontal) // Adds padding to the sides for the total section
                            .padding(.top, 25)
                        
                    
                    Spacer()
                    
                    BannerAdView()
                        .frame(width: 400, height: 50, alignment: .center)
                        .background(Color.white)

                }
            }     
            .padding(.top, 10) // Adjust the value to create desired space

            .background(Color.white)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                            HStack {
                                Image("final_app_icon") // Replace "appIcon" with your actual icon name
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                Text("Mandi Mitra")
                                    .font(.title)
                            }
                        }
                    }
            
        }
    }

}

#Preview {
    
    ItemEntry()
}


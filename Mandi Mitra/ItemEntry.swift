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
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
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
                        
                    
//                    Spacer()

                }
            }     
            .padding(.top, 20) // Adjust the value to create desired space

            .background(Color.white)
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
//                .shadow(radius: 3)
            VStack{
                HStack{
                    Text("Enter Item Rate")
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                        .font(.body)
                        .foregroundColor(Color.mandiMitraText)
                }
                HStack{
                        Group{
                            if !sellingItemPrice.isEmpty {
                                        Image("ruppee_icon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 25, height: 20)
//                                            .padding(.leading, 20)
                                    }
                            TextField("₹", text: $sellingItemPrice)
//                                .padding(.leading, 10)
                                .frame(width: 100)
                                .keyboardType(.decimalPad)
                                .foregroundColor(Color.mandiMitraText)
                        }
                        .font(Font.system(size: 40, design: .default))
                        .multilineTextAlignment(.center)
                }
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
            .multilineTextAlignment(.center)
        }        
        .padding(.leading, 20) // Add desired padding value here

//        .frame(width: 170, height: 180)

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
            VStack{
                HStack{
                    Text("You Want To Buy")
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 15))
                        .font(.body)
                        .foregroundColor(Color.mandiMitraText)
                }
                        HStack{
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
                
                Button {
                    onAddItem(sellingItemPrice, selectedSellingUnit, selectedBuyingQuantity, customKGQuantity, totalItemAmount)
                    sellingItemPrice = ""
                }
            label: {
                    Label("Add To List", systemImage: "plus.circle")
                        .font(.body)
                        .foregroundColor(Color.mandiMitraActionableButtons)
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .cornerRadius(10)
                

                 
            }
        }

        .padding(.trailing, 20)
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
//                .shadow(radius: 3)
            HStack{
                Text("Total: \u{20B9}")
                    .foregroundColor(Color.mandiMitraText)
                Text(totalBillAmount)
                    .foregroundColor(Color.mandiMitraText)
                Spacer()
                NavigationLink(destination: ViewDetailedList(items: itemsList, totalBillAmount: totalBillAmount)) {
                                    Label("View Bill", systemImage: "cart.badge.plus")
                                        .font(.body)
                                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                        .foregroundColor(Color.mandiMitraActionableButtons)
                                        .cornerRadius(10)
                                }
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 10))

        }
//        .padding(EdgeInsets(top: 30, leading: 35, bottom: 0, trailing: 35))

    }
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

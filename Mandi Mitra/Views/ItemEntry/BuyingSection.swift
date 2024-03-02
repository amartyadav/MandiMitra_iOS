//
//  BuyingSection.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 01/03/24.
//

import SwiftUI

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
                    hideKeyboard()
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

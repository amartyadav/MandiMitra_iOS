//
//  ItemRateEntry.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 01/03/24.
//

import SwiftUI

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

//
//  TotalSection.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 01/03/24.
//

import SwiftUI

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

//
//  ContentView.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 13/02/24.
//

import SwiftUI
import SwiftData

struct ViewDetailedList: View {
    var items: [ItemDetail]
    var totalBillAmount: String
    

    var body: some View {
        NavigationStack {
                List(items, id: \.id) { item in
                            VStack(alignment: .leading) {
                                HStack{
                                    Text("Selling Rate: ")
                                        .font(.body)
                                        .foregroundColor(Color.mandiMitraText)
                                    Spacer()
                                    Text(item.sellingRate)
                                        .font(.body)
                                        .foregroundColor(Color.mandiMitraText)
                                }
                                HStack{
                                    Text("Buying Quantity: ")
                                        .font(.body)
                                        .foregroundColor(Color.mandiMitraText)
                                    Spacer()
                                    Text(item.buyingQuantity)
                                        .font(.body)
                                        .foregroundColor(Color.mandiMitraText)
                                }
                                HStack{
                                    Text("Total Item Amount: ")
                                        .font(.headline)
                                        .foregroundColor(Color.mandiMitraText)
                                    Spacer()
                                    Text(item.totalItemAmount)
                                        .font(.headline)
                                        .foregroundColor(Color.mandiMitraText)
                                }

                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.mandiMitraPrimary)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                        }
                .listStyle(PlainListStyle())
                .background(Color.white)
                .onAppear {
                            printItemsList()
                        }
            HStack{
                Spacer()
                Text("Total: \u{20B9}")
                    .foregroundColor(Color.mandiMitraText)
                    .font(.title)
                Text(totalBillAmount)
                    .foregroundColor(Color.mandiMitraText)
                    .font(.title)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 10))
        }
//        .frame(width: .infinity, alignment: .leading)
        .background(Color.white)
        .toolbar {
            ToolbarItem(placement: .principal) {
                            Text("Bill Details")
                                .font(.largeTitle)
                        
                    }
                }

    }
    
    func printItemsList() {
            for item in items {
                print("Selling Rate: \(item.sellingRate), Buying Quantity: \(item.buyingQuantity), Total Item Amount: \(item.totalItemAmount)")
            }
        }

}

let sampleItemList: [ItemDetail] = [
    ItemDetail(sellingRate: "Rs. 12/paao", buyingQuantity: "1 Paao", totalItemAmount: "Rs. 12", customKGQuantity: nil),
    ItemDetail(sellingRate: "Rs. 24/half kg", buyingQuantity: "Half KG", totalItemAmount: "Rs. 24", customKGQuantity: nil),
    ItemDetail(sellingRate: "Rs. 48/kg", buyingQuantity: "1 KG", totalItemAmount: "Rs. 48", customKGQuantity: nil),
    ItemDetail(sellingRate: "Rs. 12/paao", buyingQuantity: "More KG", totalItemAmount: "Rs. 96", customKGQuantity: "2"),
    ItemDetail(sellingRate: "Rs. 24/half kg", buyingQuantity: "3 Paao", totalItemAmount: "Rs. 36", customKGQuantity: nil)
]

#Preview {
    ViewDetailedList(items: sampleItemList, totalBillAmount: "325.00")
}

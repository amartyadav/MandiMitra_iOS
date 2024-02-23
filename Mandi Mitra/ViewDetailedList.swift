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
    

    var body: some View {
        NavigationSplitView {
                List(items, id: \.id) { item in
                            VStack(alignment: .leading) {
                                Text("Selling Rate: \(item.sellingRate)")
                                Text("Buying Quantity: \(item.buyingQuantity)")
                                Text("Total Item Amount: \(item.totalItemAmount)")
                                // Display more details as needed
                            }
                        }.onAppear {
                            printItemsList()
                        }
            .toolbar {
                ToolbarItem {
                    Label("Add Item", systemImage: "gear")
                }
            }
            .navigationTitle("Mandi Mitra")
        } detail: {
            Text("Select an item")
        }
    }
    
    func printItemsList() {
            for item in items {
                print("Selling Rate: \(item.sellingRate), Buying Quantity: \(item.buyingQuantity), Total Item Amount: \(item.totalItemAmount)")
            }
        }

}



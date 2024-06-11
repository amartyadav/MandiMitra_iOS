//
//  ItemDetail.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 20/02/24.
//

import Foundation
/// Contains the basic model for an item that is added to the final bill. Each model contains id, sellingRate (Rs. 12/paao -> numerical price + selling unit), buying quantity, and the total amount for that item based on the rate and buying quantity
struct ItemDetail: Identifiable {
    let id = UUID()
    var sellingRate: String
    var buyingQuantity: String
    var totalItemAmount: String
    var customKGQuantity: String?
    var gramQuantity: String?
}

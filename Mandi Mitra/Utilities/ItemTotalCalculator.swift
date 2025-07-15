//
//  ItemTotalCalculator.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 19/02/24.
//

import Foundation

struct ItemTotalCalculator {
    static func calculateItemTotal(price: String, sellingQuantityUnitSelected: ItemEntry.sellingItemUnit, buyingQuantityUnitSelected: ItemEntry.buyingQuantity, customQuantity: String?, gmQuantity: String?) -> Double {
        let pricePerUnit = Double(price) ?? 0.0
        var totalItemCost = 0.0
        
        // Assuming you have defined these string constants somewhere
        let KG = ItemEntry.sellingItemUnit.KG
        let paao = ItemEntry.sellingItemUnit.Paao
        let gram = ItemEntry.sellingItemUnit.hundred_gram

        let one_paao = ItemEntry.buyingQuantity.one_paao
        let half_kg = ItemEntry.buyingQuantity.half_kg
        let three_paao = ItemEntry.buyingQuantity.three_paao
        let one_kg = ItemEntry.buyingQuantity.one_kg
        let more_kg = ItemEntry.buyingQuantity.more_kg
        let hundredGm = ItemEntry.buyingQuantity.gram
        
        let customQuantityDouble = Double(customQuantity ?? "") ?? 0.0
        let gmQuantityDouble = Double(gmQuantity ?? "") ?? 0.0
        
        print(gmQuantity, gmQuantityDouble)
        print(sellingQuantityUnitSelected)
        
        if sellingQuantityUnitSelected == paao {
            switch buyingQuantityUnitSelected {
            case one_paao:
                totalItemCost = pricePerUnit * 1
            case half_kg:
                totalItemCost = pricePerUnit * 2
            case three_paao:
                totalItemCost = pricePerUnit * 3
            case one_kg:
                totalItemCost = pricePerUnit * 4
            case more_kg:
                totalItemCost = pricePerUnit * customQuantityDouble * 4
            default:
                break
            }
        } else if sellingQuantityUnitSelected == KG {
            switch buyingQuantityUnitSelected {
            case one_paao:
                totalItemCost = pricePerUnit * 0.25
            case half_kg:
                totalItemCost = pricePerUnit * 0.5
            case three_paao:
                totalItemCost = pricePerUnit * 0.75
            case one_kg:
                totalItemCost = pricePerUnit * 1
            case more_kg:
                totalItemCost = pricePerUnit * customQuantityDouble
            default:
                break
            }
        } else if sellingQuantityUnitSelected == gram {
            switch buyingQuantityUnitSelected {
            case one_paao:
                print("case 1")
                totalItemCost = pricePerUnit * (250 / 100)
            case half_kg:
                print("case 2")
                totalItemCost = pricePerUnit * (500 / 100)
            case three_paao:
                print("case 3")
                totalItemCost = pricePerUnit * (750 / 100)
            case one_kg:
                print("case 4")
                totalItemCost = pricePerUnit * (1000 / 100)
            case more_kg:
                print("case 5")
                totalItemCost = pricePerUnit * (customQuantityDouble / 100)
            case hundredGm:
                print("case 6")
                totalItemCost = pricePerUnit * (gmQuantityDouble / 100)
            default:
                break
            }
        }
        
        return totalItemCost
    }

}

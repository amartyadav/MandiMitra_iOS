//
//  Item.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 13/02/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

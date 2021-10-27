//
//  ProductDataModel.swift
//  CollectionViewExample
//
//  Created by Jesus Jaime Cano Terrazas on 25/09/21.
//

import Foundation

class ProductDataModel: Codable {
    var description = ""
    var price = ""
    var sku = ""
    var url = ""
    var name = ""
    var brand = ""
}


extension ProductDataModel {
    var formattedPrice: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "€"
        numberFormatter.currencyDecimalSeparator = "."
        numberFormatter.currencyGroupingSeparator = ","
        
        if let doublePrice = Double(price) {
            let numberPrice = NSNumber(value: doublePrice)
            
            return numberFormatter.string(from: numberPrice) ?? "€\(price)"
        }
        
        return "€\(price)"
    }
}

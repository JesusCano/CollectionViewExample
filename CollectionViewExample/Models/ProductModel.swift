//
//  ProductModel.swift
//  CollectionViewExample
//
//  Created by Jesus Jaime Cano Terrazas on 25/09/21.
//

import Foundation

class ProductModel: Codable {
    var images: [ProductImageModel]
    var data: ProductDataModel
    var id = ""
}
